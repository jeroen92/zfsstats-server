# Migrate the old measuremnet.data to measurement.measurement_data.data for an easier to handle measurement model
class MigrateMeasurementData < Mongoid::Migration
  
  mongo_db = Mongoid::Sessions.default

  def test
    mongo_db[:measurement_data].find.each do |measurementdata|
      msd = Hash[measurementdata]
      puts(msd['measurement_id']).to_s
      if msd['measurement_id']
        ms = mongo_db[:measurements].find(_id: msd['measurement_id'])
        #puts ms.inspect
        #.update({ "$set" => { measurement_data_id: msd['_id'] }})
      else
        #mongo_db[:measurement_data].find(_id: msd['_id']).remove_all
      end
      #ms = mongo_db[:measurements].find(_id: msd['measurement_id']).first
    end

    #testing...
    #msd = MeasurementData.where(measurement_id: measurement.id).first
    #measurement.measurement_data_id = msd.id
    #puts measurement.inspect
    #measurement.update
  end


    mongo_db[:measurements].find.update_all({ "$unset" => { data: true }})

  #mongo_db[:measurements].find.each do |measurement|
  #	ms = Hash[measurement]
  #	puts ms['name']
  	#measurement.update("$set" => { data: [0] })
  	
  #end
  def migrateMeasurementData
	  mongo_db[:measurements].find.each do |measurement|
	    ms = Hash[measurement]
	    puts 'current measurement = ' + ms['name']
	    mongo_db[:measurement_data].insert(data: ms['data'])
      newms = mongo_db[:measurement_data].find(data: ms['data']).first
      newMeasurementId = Hash[newms]["_id"]
      puts 'measurement id = ' + ms['_id']
      puts 'new measurement data id = ' + newMeasurementId
      puts mongo_db[:measurements].where(_id: ms['_id']).update({ "$set" => { measurement_data_id: newMeasurementId }})
      puts 'record updated........'
	  end
  end
end