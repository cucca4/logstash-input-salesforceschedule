@@ -88,17 +88,42 @@ class LogStash::Inputs::Salesforce < LogStash::Inputs::Base
  
  config_name "salesforceschedule"
  config :sfdc_filters, :validate => :string, :default => ""
  # Setting this to true will convert SFDC's NamedFields__c to named_fields__c
  config :to_underscores, :validate => :boolean, :default => false
  # Schedule of when to periodically run statement, in Cron format
  # for example: "* * * * *" (execute query every minute, on the minute)
  #
  # There is no schedule by default. If no schedule is given, then the statement is run
  # exactly once.
  config :schedule, :validate => :string

  public
  def register
    require 'restforce'
    require 'rufus/scheduler'
    obj_desc = client.describe(@sfdc_object_name)
    @sfdc_field_types = get_field_types(obj_desc)
    @sfdc_fields = get_all_fields if @sfdc_fields.empty?
  end # def register

  public
  def run(queue)
    if @schedule
      @scheduler = Rufus::Scheduler.new(:max_worker_thread => 1)
      @scheduler.cron @schedule do
        execute_query(queue)
      end

      @scheduler.join
    else
      execute_query(queue)
    end
  end # def run

  def stop
    @scheduler.shutdown(:wait) if @scheduler
  end

  private
  def execute_query(queue)
    results = client.query(get_query())
    if results && results.first
      results.each do |result|
@@ -120,7 +145,7 @@ def run(queue)
        queue << event
      end
    end
  end # def run
  end

  private
  def client
