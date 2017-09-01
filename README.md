# Idoru

A framework for building **API.AI** bot fulfillment webhooks using **Rack** based `HTTP` servers. The basic idea is to leverage the standard MVC idiom where requests are dispatched to fulfillment controllers and the appropriate method names by mapping API.AI actions. The message rendering will use **API.AI** supported messaging platforms by rendering the **API.AI** supported `JSON`. The goal is to keep it lightweight and to remove the typical web server infrastructure for supporting web pages. Idoru will reduce the code for double dispatch from `POST` to webhook actions and increase some flexibility in routing based on action routing.

## Initial Framework User Stories 
 
### API.AI Action Format
**API.AI** intent actions should use the following naming convention:

    bot_name.*.fulfillment_controller.fulfillment_action
              
     weather.forecasts.five_day
       ^        ^        ^
       |        |        |
      bot       |        |
            controller   |
                       method


**Naming Convention:**

* The first word `weather` should be the name of the bot
* The second to last word `forecasts` should be the controller name
* The last word `five_day` should be the method name
* Any words used in between the above conventions can be used for name spacing or scoping and might provide some action routing flexibility

### Command Line Tools
Generators will be provided to help expedite development and testing. 
When the command line generators are built the goal is to get them to operate as demonstrated below:   

    
    $ idoru bot weather                                         # create a weather bot webhook project
    
    $ cd weather                                                # change into the project

    $ idoru generate fulfillment forecasts five_day historical  # generate a fulfillment controller with methods five_day and historical
    
    $ idoru generate message --platform apiai,slack,facebook forecasts:five_day,historical   # generate the return message
    
    $ idoru generate scaffold --platform apiai,slack,facebook forecasts:five_day,historical  # single command to do both of the two previous commands
    
### Fulfillment Controller
The goal of the controller:

 * Dispatch to a mapped fulfillment controller and method according to the API.AI action
 * Easier access API.AI JSON data through request and response objects 
 * Help make it easier to access and validate webhook request data
 * Quicker integration to on-site and remote systems
 * Prep data for message rendering
 
 
        class ForecastsFulfillment < FulfillmentBase
      
            def five_day
                @city = params['city']
                @user = request.context[user]
                @forecasts = weather_api.five_day(@city)
                response.context_out << ApiAiRuby::Context.new('five_day_city', 3, { city: @forecasts.city })
                render 
            end
            
        end

### Message Rendering
Message rendering should make it easier to take the data collected in the controller and fill out messaging templates. Messaging templates should be able to be generate some scaffolding

    # idoru generate message --platform apiai --type card color_picker:pick_one

    pick_one.json.apiai.card.erb
    
    {
        type: 1,
        title: Colors,
        subtitle: Select one
        butons: <% @colors.map { |color| {text: color.name, postback: color.rgb} } %> 
    }

### API.AI Action Routing:

The action routing config will allow some flexibility.

    Idoru.application.actions.generate do
    
      fulfillment 'weather.forecasts.five_day', to: 'forecasts#five_day'
    
    end     

### Notes
On a current project I have built an initial quick solution on **Sinatra** that has a few aspects of this solution. My plan to hopefully replace the **Sinatra** solution with **Idoru**.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'idoru'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install idoru

## Usage



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/idoru. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Idoru project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/idoru/blob/master/CODE_OF_CONDUCT.md).
