class ImportData
  class << self
    def from_xml(xml_io)
      hash_result = ActionPack::XmlParser.call(xml_io)['Root']

      if ParcelList.find_by_guid(hash_result['Root']['FileAttribute']['GUID']).blank?
        ParcelList.create(
          guid: hash_result['FileAttribute']['GUID'],
          batch_id: hash_result['FileData']['Batch']['BatchID'],
          creation_date: hash_result['FileData']['Batch']['CreationDate']
        )
      end

      return { result.root.name.to_sym => xml_node_to_hash(result.root)}
    rescue Exception => e
      puts e.message
    end

    private


  end
end
