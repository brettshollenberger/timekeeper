require 'action_view'

include ActionView::Helpers::DateHelper

class Launcher < ActiveRecord::Base
  attr_accessible :checkins, :historic_time, :in, :in_time, :name

  def checkin
    if !in?
      self.in = 't'
      add_checkin
      record_in_time
      self.save
    else
      puts "You're already checked in."
    end
  end

  def checkout
    if in?
      self.in = 'f'
      spent, in_words = time_spent
      add_to_historic_time(spent)
      total_spent = format_days_hours_minutes_seconds(self.historic_time)
      puts "You worked for #{in_words.downcase}"
      puts "Overall, you've worked #{total_spent}"
      self.save
    else
      puts "You're already checked out."
    end
  end

  def in?
    if self.in == 't'
      true
    else
      false
    end
  end

  def add_checkin
    self.checkins += 1
  end

  def record_in_time
    self.in_time = Time.now
  end

  def time_spent
    spent = (Time.now - self.in_time).to_i
    in_words = distance_of_time_in_words(self.in_time, Time.now)
    return spent, in_words
  end

  def add_to_historic_time(spent)
    self.historic_time += spent
  end

  def format_days_hours_minutes_seconds(spent)
    if spent >= 86400
      formatted_days = (spent / 86400).to_i
      subtract_days = formatted_days * 86400
      formatted_hours = ((spent - subtract_days) / 3600).to_i
      subtract_hours = formatted_hours * 3600
      formatted_minutes = ((spent - subtract_days - subtract_hours) / 60).to_i
      subtract_minutes = formatted_minutes * 60
      formatted_seconds = spent - subtract_days - subtract_hours - subtract_minutes
      formatted_return = "#{formatted_days} days, #{formatted_hours} hours, #{formatted_minutes} minutes, and #{formatted_seconds} seconds."
      return formatted_return
    elsif spent >= 3600
      formatted_hours = (spent / 3600).to_i
      subtract_hours = formatted_hours * 3600
      formatted_minutes = ((spent - subtract_hours) / 60).to_i
      subtract_minutes = formatted_minutes * 60
      formatted_seconds = spent - subtract_hours - subtract_minutes
      formatted_return = "#{formatted_hours} days, #{formatted_minutes} minutes, and #{formatted_seconds} seconds."
      return formatted_return
    elsif spent >= 60
      formatted_minutes = (spent  / 60).to_i
      subtract_minutes = formatted_minutes * 60
      formatted_seconds = spent - subtract_minutes
      formatted_return = "#{formatted_minutes} minutes and #{formatted_seconds} seconds."
      return formatted_return
    else
      return "#{spent}"
    end
  end
end
