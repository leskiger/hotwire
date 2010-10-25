# Hotwire

Hotwire is designed to ease the pain of creating Google Wire Protocol compatible data source in Ruby. Specifically, Hotwire can make it dead simple to provide data for the Google Visualization API.

This class implements a Google Visualization API Wire Protocal Datasource, as defined [here](http://code.google.com/intl/it/apis/visualization/documentation/dev/implementing_data_source.html).

You can use it to wrap your custom data into a json, csv, or html output compliant with the Google Visualization APIs specifications.

Google Visualization APIs define a standard format to express tabular data with typed columns. By exposing your data in such format, you can use all the existing visualizations conforming to the specification out-of-the-box to represent and analyze your data.

You can read more about the GViz API here: http://code.google.com/apis/visualization.

It implements most of the standard with the exclusion of:
  * Query language (tq parameters)
  * Caching (sig parameters)
  * some warnings and error types in the JSON response

It supports version 0.5 of the APIs.

## Basic Use
The basic use follows this pattern:

* create an instance from the request params using the Hotwire::Request.from_paramsfactory method.
* verify that the instance is valid
* create a response object using the request.build_response method
* add columns to the response using add_column.
* add a dataset to the response using set_data.
* invoke the body method to return the datasource formatted according to the Wire Protocol in the requested format.

Depending on the request parameters, the body method will either return a json or csv string. When an html response is requested, nothing is returned by this class itself can be passed to a view to generate the HTML report.

The dataset is expected to be a 2-dimensional array (the first index referencing the rows, the second the columns). More generally, it can be anything that supports a 2 nested iteration cycles: the first on rows, the second on columns.

The columns ordering in the dataset must match the order used to add them via the add_column method. Aka, add_column must be invoked for each column in the same order used by the dataset (and expected in the produced output).

## Example
The following is a basic example of use. 

    class YourController < ApplicationController
        def yourmethod
            data = [
                [ Date.today, 'hello', 10 ],
                [ Date.today - 1, 'world', 20 ]
            ]
            respond_to do |wants|
                wants.json do
                    if wire_request = Hotwire::Request.from_param(params)
                        wire_response = wire_request.build_response
                        wire_response.add_col('date', :id => 'A' , :label => 'Date').
                                      add_col('string', :id => 'B' , :label => 'Name').
                                      add_col('number', :id => 'C', :label => 'Count').
                                      set_data(data) if wire_request.valid?
                        wire_response.body
                    else
                        data.to_json
                    end
                end
            end
        end
    end

## ActiveRecord ##

If your project includes ActiveRecord, Hotwire will automatically included an ActiveRecord mixin that allows columns to be added from a model class.

Let's say you have a Person Model:
    
    Class Person < ActiveRecord::Base
    end
    
Then, when you have created your response object, you can add all the columns from the Person Model: 

    ...
    wire_response.add_columns(Person)
    ...
    
Finally, you can pass a collection of People to set_data:

    ...
    @people = Personal.find(:all)
    wire_response.set_data(@people)
    ...
    
You can also set the columns manually and then still use set_data with a collection. This will only set data with columns you have already added, matching the id key of the column definition to the attribute on your objects:

    ...
    wire_response.add_col('string', :id => 'name' , :label => 'Name').
                  add_col('number', :id => 'age' , :label => 'Age')
    wire_response.set_data(Person.all)
    ...
    
In that case, your wire_response.data will look like:

    wire_response.data => [['Bob', 33], ['Fred', 22]]
                  
    
## ToDo
TODO: should be updated to handle version 0.6 of the API

## Author ##
Les Kiger [les@codebenders.com]

## Acknowledgements
This code is heavily based on the GVis class by Riccardo Govoni [battlehorse@gmail.com].

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Les Freeman. See LICENSE for details.
