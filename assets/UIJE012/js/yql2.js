/*original from Zara, modified to suit with Au weather */
(function($){

	$.fn.weatherfeed = function(locations, options, fn) {	
	
		// Set plugin defaults
		var defaults = {
			unit: 'c',
			image: true,
			country: false,
			highlow: true,
			wind: true,
			humidity: false,
			visibility: false,
			sunrise: false,
			sunset: false,
			forecast: false,
			link: true,
			showerror: true,
			linktarget: '_self',
			woeid: false
		};  
		var options = $.extend(defaults, options); 
		var row = 'odd';

		// Functions
		return this.each(function(i, e) {
			var $e = $(e);
			
			// Add feed class to user div
			if (!$e.hasClass('weatherFeed')) $e.addClass('weatherFeed');

			// Check and append locations
			if (!$.isArray(locations)) return false;

			var count = locations.length;
			if (count > 10) count = 10;

			var locationid = '';

			for (var i=0; i<count; i++) {
				if (locationid != '') locationid += ',';
				locationid += "'"+ locations[i] + "'";
			}

			// Cache results for an hour to prevent overuse
			now = new Date();

			// Select location ID type
			var queryType = options.woeid ? 'woeid' : 'location';
					
			var url2 = "http://api.openweathermap.org/data/2.5/forecast?q=";
			var url = "http://api.openweathermap.org/data/2.5/weather?q=";
			var param = ",au&units=metric&appid=59098b0f3bd1953d615623ebc3b52e43";
			
			var api =  url + locations + param;
if (options.forecast) api =  url2 + locations + param;
              
			// Send request
			$.ajax({
				type: 'GET',
				url: api,
				dataType: 'json',
				success: function(data) {

					if (data) {
			
						

							// Single location only
							_process(e, data, options);
						

						// Optional user callback function
						if ($.isFunction(fn)) fn.call(this,$e);

					} else {
						if (options.showerror) $e.html('<p>Weather information unavailable</p>');
					}
				},
				error: function(data) {
					if (options.showerror) $e.html('<p>Weather request failed</p>');
				}
			});

			// Function to each feed item
			var _process = function(e, feed, options) {
				var $e = $(e);

// forecast
if (options.forecast) {
 
//					$('.weatherFeed').text(feed.city.name);
						html = '';
						html += '<div class="weatherForecast"> ' ;

						var wfi = feed.list;

						for (var i=0; i<wfi.length; i++) {

var date = new Date(wfi[i].dt*1000);

var thedate = date.toString().slice(0,3);
// Hours part from the timestamp
var hours = date.getHours();
// Minutes part from the timestamp
var minutes = "0" + date.getMinutes();
// Seconds part from the timestamp
var seconds = "0" + date.getSeconds();

// Will display time in 10:30:23 format
var formattedTime = hours + ':' + minutes.substr(-2) + ':' + seconds.substr(-2);					 
mtime = formattedTime;			 

//temp = Math.round(Number(feed.main.temp) -273.15);
temp = Math.round(Number(wfi[i].main.temp));
img= "http://openweathermap.org/img/w/" + wfi[i].weather[0].icon +".png"; 
html += '<div class="weatherForecastItem" style="background-image: url(' + img + '); background-repeat: no-repeat;background-position: bottom left; background-size: 60px 60px; text-align: right">'; 
/*							html += '<div class="weatherForecastDay">'+ wfi[i].day +'</div>';
							html += '<div class="weatherForecastDate">'+ wfi[i].date +'</div>'; */
							html += '<div class="weatherTemp">' + temp +'&deg; </div>';
					        html += '<div class="weatherDesc">'+ wfi[i].weather[0].description +'</div>';
							//html += '<div class="rangelow">'+wfi[i].low +'</div>' + '<div class="rangehi">'+wfi[i].high +'</div>';  
							html += '<div class="weatherForecastDay">'+ thedate + " " + mtime +  '</div>';
						//	html += '<div class="weatherForecastText">'+ wfi[i].text +'</div>';
							
//							html += '<div class="weatherForecastRange">High: '+ wfi[i].high +' Low: '+ wfi[i].low +'</div>';
							html += '</div>'
						}

						html += '</div>'
					
 }

				// Check for invalid location
else if (feed.name) {

					 daynight = 'day'; 
var date = new Date(feed.dt*1000);
// Hours part from the timestamp
var hours = date.getHours();
// Minutes part from the timestamp
var minutes = "0" + date.getMinutes();
// Seconds part from the timestamp
var seconds = "0" + date.getSeconds();

// Will display time in 10:30:23 format
var formattedTime = hours + ':' + minutes.substr(-2) + ':' + seconds.substr(-2);					 
mtime = formattedTime;
//temp = Math.round(Number(feed.main.temp) -273.15);
temp = Math.round(Number(feed.main.temp));

					// Add item container
					var html = '<div class="weatherItem limg '+ row +' '+ daynight +'"';
					img= "http://openweathermap.org/img/w/" + feed.weather[0].icon + ".png";
					if (options.image) html += ' style="background-image: url(' + img + '); background-repeat: no-repeat; background-position: bottom left; background-size: 60px 60px;"';
					html += '>';
		
					// Add item data
					if (feed.name == "Liverpool") feed.name = "Cabramatta"; 
					if (feed.name == "Spring Hill") feed.name = "Brisbane"; 
					html += '<div class="weatherCity">'+ feed.name + ' @ '+ mtime +'</div>';
//if (options.country) html += '<div class="weatherCountry">'+ feed.sys.country +'</div>';
					html += '<div class="weatherTemp">' + temp +'&deg; </div>';
					html += '<div class="weatherDesc">'+ feed.weather[0].description +'</div>';
				
					// Add optional data
					//if (options.highlow) html += '<div class="weatherRange">Low: '+ wf.low +'&deg; High: '+ wf.high +'&deg;</div>';
					if (options.wind) html += '<div class="weatherWind">Wind: '+  feed.wind.speed + '</div>';
					if (options.humidity) html += '<div class="weatherHumidity">Humidity: '+ feed.main.humidity +'</div>';
					//if (options.visibility) html += '<div class="weatherVisibility">Visibility: '+ feed.atmosphere.visibility +'</div>';
					if (options.sunrise) html += '<div class="weatherSunrise">Sunrise: '+ feed.sys.sunrise +'</div>';
					if (options.sunset) html += '<div class="weatherSunset">Sunset: '+ feed.sys.sunset +'</div>';

					// Add item forecast data


					if (options.link) html += '<div class="weatherLink"><a href="'+ feed.link +'" target="'+ options.linktarget +'" title="Read full forecast">Full forecast</a></div>';

				} else {
					var html = '<div class="weatherItem '+ row +'">';
					html += '<div class="weatherError">City not found</div>';
				}

				html += '</div>';

				// Alternate row classes
				if (row == 'odd') { row = 'even'; } else { row = 'odd';	}
		
				$e.append(html);
			
			};

			// Get time string as date
			var _getTimeAsDate = function(t) {
		
				d = new Date();
				r = new Date(d.toDateString() +' '+ t);

				return r;
			};

		});
	};

})(jQuery);
