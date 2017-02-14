class AirlineBookController < ApplicationController

	helper :all

   $totalfare = 0 
    def index
      @sector = Sector.where(:quote_id => session[:session_id])
      @passenger = Passenger.where(:quote_id => session[:session_id])
       redirect_to :action => "start"
      
    end

     def start
      # destroy_farequote
      @sector = Sector.where(:quote_id => session[:session_id])
      @passenger = Passenger.where(:quote_id => session[:session_id])

     
     end

  def add_sector
    @sector =Sector.new
  end

  
  def save_sector
    
    @sector = Sector.new(allow_param)
    if @sector.save
      redirect_to :action => "start"
    else
      render 'add_sector' 
    end
  end
  
    def allow_param
      params.require(:sector).permit(:flight_name, :airline_no, :departure, :arrival, :base_fare).merge(quote_id: session[:session_id])
    end

    def add_passenger
      @passenger = Passenger.new
    end
  
   def save_passenger
    @passenger = Passenger.new(param_passenger)
    if @passenger.save
      redirect_to :action => "start"
    else
      render 'add_passenger' 
    end
   end
    
    def param_passenger
      params.require(:passenger).permit(:quote_id,:title, :pass_name, :category ).merge(quote_id: session[:session_id])
    end



    def destroy_Sector
      @sector = Sector.where(:quote_id => session[:session_id])
      @sector.destroy_all
      redirect_to :action => "start"
    end
    
    
    def destroy_Passenger
    @passenger = Passenger.where(:quote_id => session[:session_id])
    @passenger.destroy_all
    redirect_to :action => "start"
    end

    
    def param_fare_quote
      
      params.require(:farequote).permit(:name, :dep, :arr, :set_tax, :kri_kal_cess, :swc_bha_cess, :cute_fee, :fare, :category ).merge(quote_id: session[:session_id])
      
    end
    
    
    def farequote
      
    flash[:notice] = "Your Data Save succesfully!!"

    fare

    
    $totalfare = 0   
    @temp_array = []
    @total_fare = 0
    @total_fare_overall = 0
    @infant_fare = 1500
    @sector = Sector.where(:quote_id => session[:session_id])
    @passenger = Passenger.where(:quote_id => session[:session_id])
   
    
    @sector.each do |sector|
      dep_passen_ser_fee,arr_passen_ser_fee,user_dev_fee = 0,0,0
      
       @total_fare = 0
    
            if sector.departure == "DEL" 
              dep_passen_ser_fee = 245
              user_dev_fee = 245
              elsif sector.departure == "BOM"
                dep_passen_ser_fee = 353
                user_dev_fee = 353
              elsif sector.departure == "HYD"
                dep_passen_ser_fee = 237
                user_dev_fee = 0
              elsif sector.departure == "MAA"
                dep_passen_ser_fee = 152
                user_dev_fee = 0
              elsif sector.departure == "BLR"
                dep_passen_ser_fee = 621
                user_dev_fee = 0
              else
                dep_passen_ser_fee = 0
                user_dev_fee = 0
            end
            
                if sector.arrival == "DEL"
                  arr_passen_ser_fee = 245
                elsif sector.arrival == "BOM"
                  arr_passen_ser_fee = 353
                elsif sector.arrival == "BLR"
                  arr_passen_ser_fee = 621
                else
                  arr_passen_ser_fee = 0
                end
                    
                      if sector.flight_name == "SG" || sector.flight_name == "6E"
                           cf = 50
                         else
                           cf = 0
                      end
  
              @passenger.each do |passenger|
              
              final_base_fare = 0
              fare_cf = 0
              service_tax = 0
              krishi_kalyan_cess = 0
              swach_bharath_cess = 0
              fare_with_taxes = 0
               @total_fare = 0
  
                          case passenger.category
                              when "Infant"
                         
                              @total_fare += @infant_fare
                            
                              when "Child"
                                final_base_fare = sector.base_fare * 0.5
                                    
                              when "Adult"
                                final_base_fare = sector.base_fare
                           
                   
                              else
                            puts "Invalid Category"
                          end
        
                              fare_cf = final_base_fare + cf
                              service_tax = 0.6 * fare_cf * 0.145
                              krishi_kalyan_cess = 0.005 * fare_cf
                              swach_bharath_cess = 0.005 * fare_cf
                              
                                    if passenger.category == "Infant"
                                      @total_fare
                                    else 
                                      fare_with_taxes = fare_cf + service_tax + krishi_kalyan_cess + swach_bharath_cess + dep_passen_ser_fee + arr_passen_ser_fee + user_dev_fee
                                      @total_fare += fare_with_taxes
                                    end
                                    
                                    @total_fare_overall += @total_fare
                                    $totalfare += @total_fare
                                    

                                          
                                    @fare_quote = Farequote.new
                                    @fare_quote.name = passenger.pass_name
                                    @fare_quote.dep =  sector.departure
                                    @fare_quote.arr = sector.arrival
                                    @fare_quote.set_tax = service_tax
                                    @fare_quote.kri_kal_cess = krishi_kalyan_cess
                                    @fare_quote.swc_bha_cess = swach_bharath_cess
                                    @fare_quote.cute_fee = cf
                                    @fare_quote.fare = @total_fare
                                    @fare_quote.quote_id = session[:session_id]
                                    @fare_quote.category = passenger.category
                                    @fare_quote.save
                                  
                                    
                                   
                 end
                
      end
    	@farequote = Farequote.where(:quote_id => session[:session_id])
  
    end
    
    def destroy_farequote
      
     @farequote = Farequote.where(:quote_id => session[:session_id])
     @farequote.destroy_all
      
    end
    
    
    
           
    def calculate_fare
     
      
    $totalfare = 0   
    #@fares_array = []
    @temp_array = []
    #@temp = { }
    @total_fare = 0
    @total_fare_overall = 0
    @infant_fare = 1500
    @sector = Sector.where(:quote_id => session[:session_id])
    @passenger = Passenger.where(:quote_id => session[:session_id])
    #@user = User.where(:quote_id => session[:session_id])
    #@fare_quote1 = Fare_quote.where(:quote_id => session[:session_id])
    
    @sector.each do |sector|
      dep_passen_ser_fee,arr_passen_ser_fee,user_dev_fee = 0,0,0
      
       @total_fare = 0
    
            if sector.departure == "DEL" 
              dep_passen_ser_fee = 245
              user_dev_fee = 245
              elsif sector.departure == "BOM"
                dep_passen_ser_fee = 353
                user_dev_fee = 353
              elsif sector.departure == "HYD"
                dep_passen_ser_fee = 237
                user_dev_fee = 0
              elsif sector.departure == "MAA"
                dep_passen_ser_fee = 152
                user_dev_fee = 0
              elsif sector.departure == "BLR"
                dep_passen_ser_fee = 621
                user_dev_fee = 0
              else
                dep_passen_ser_fee = 0
                user_dev_fee = 0
            end
            
                if sector.arrival == "DEL"
                  arr_passen_ser_fee = 245
                elsif sector.arrival == "BOM"
                  arr_passen_ser_fee = 353
                elsif sector.arrival == "BLR"
                  arr_passen_ser_fee = 621
                else
                  arr_passen_ser_fee = 0
                end
                    
                      if sector.flight_name == "SG" || sector.flight_name == "6E"
                           cf = 50
                         else
                           cf = 0
                      end
  
              @passenger.each do |passenger|
              
              final_base_fare = 0
              fare_cf = 0
              service_tax = 0
              krishi_kalyan_cess = 0
              swach_bharath_cess = 0
              fare_with_taxes = 0
               @total_fare = 0
  
                          case passenger.category
                              when "Infant"
                         
                              @total_fare += @infant_fare
                            
                              when "Child"
                                final_base_fare = sector.base_fare * 0.5
                                    
                              when "Adult"
                                final_base_fare = sector.base_fare
                           
                   
                              else
                            puts "Invalid Category"
                          end
        
                              fare_cf = final_base_fare + cf
                              service_tax = 0.6 * fare_cf * 0.145
                              krishi_kalyan_cess = 0.005 * fare_cf
                              swach_bharath_cess = 0.005 * fare_cf
                              
                                    if passenger.category == "Infant"
                                      @total_fare
                                    else 
                                      fare_with_taxes = fare_cf + service_tax + krishi_kalyan_cess + swach_bharath_cess + dep_passen_ser_fee + arr_passen_ser_fee + user_dev_fee
                                      @total_fare += fare_with_taxes
                                    end
                                    
                                    @total_fare_overall += @total_fare
                                    $totalfare += @total_fare

                                    
              
                                    @temp_array.push([passenger.category,passenger.pass_name,sector.departure,sector.arrival,service_tax,krishi_kalyan_cess,swach_bharath_cess,cf,@total_fare])

                                    
                                   
                 end
                
    end
      
      

  end


def search

	#@farequote = Farequote.all(:name)
	@farequote = Farequote.find_by_name(params["name"])
end


    
end
