class ImportData
  class << self
    def from_xml(file_xml)
      create_parcel_list(ActionPack::XmlParser.call(file_xml)['Root'])
    rescue StandardError => e
      Rails.logger.import_data.error "\n#{e.message}\n#{e.backtrace}"
    end

    private

    # Создаём список посылок
    def create_parcel_list(hash_result)
      parcel_list = ParcelList.new(guid:          hash_result['FileAttribute']['GUID'],
                                   batch_id:      hash_result['FileData']['Batch']['BatchID'],
                                   creation_date: hash_result['FileData']['Batch']['CreationDate'])

      # Возвращаем если данный список не проходит валидацию по guid и batch_id
      return unless parcel_list.save!

      hash_result = hash_result['FileData']

      if hash_result['Invoice'].is_a? Array
        hash_result['Invoice'].each do |hash_invoice|
          create_invoice(parcel_list, hash_invoice)
        end
      else
        create_invoice(parcel_list, hash_result['Invoice'])
      end
    end

    # Создаём посылку
    def create_invoice(parcel_list, hash_invoice)
      invoice = parcel_list.invoices.new(company_code:     hash_invoice['InvoiceOperation']['CompanyCode'],
                                         operation_number: hash_invoice['InvoiceOperation']['InvoiceOperationNumber'],
                                         operation_date:   hash_invoice['InvoiceOperation']['InvoiceOperationDate'])

      if hash_invoice['InvoiceData'].is_a? Array
        hash_invoice['InvoiceData'].each do |hash_product|
          new_product(invoice, hash_product)
        end
      else
        new_product(invoice, hash_invoice['InvoiceData'])
      end

      invoice.save!
    end

    # Новый продукты
    def new_product(invoice, hash_product)
      invoice.products.new(parcel_code: hash_product['ParcelCode'],
                           quantity:    hash_product['ItemQty'],
                           price:       hash_product['ParcelPrice'])
    end
  end
end
