class EntryList
  def initialize(entries = [])
    @entries = {}
    entries.each do |entry|
      @entries[entry.id] = entry
    end
  end

  def add_entry(entry)
    @entries[entry.id] = entry
  end

  def each(&block)
    @entries.values.each(&block) 
  end

  def has_entry?(entry_id)
    @entries.key?(entry_id)
  end

  def get_entry(entry_id)
    @entries[entry_id]
  end

  def remove_entry(entry_id)
    @entries.delete(entry_id)
  end
end
