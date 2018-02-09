class BeeSpecies < StaticCollection::Base
  set_source YAML.load_file('./data/bee_species.yml')
end
