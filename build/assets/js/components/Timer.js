(function() {
  var Timer, TimerSegment,
    __slice = [].slice;

  Timer = React.createClass({
    getInitialState: function() {
      var args, countdown, date, el, name, segments;
      el = $('#countdown-timer');
      date = el.data('event-date');
      name = el.data('event-name');
      segments = el.data('segments').split(',');
      args = [date].concat(segments);
      countdown = this.calculateCountdown.apply(this, args);
      return {
        segments: segments,
        countdown: countdown,
        event: {
          name: name,
          date: date
        }
      };
    },
    componentDidMount: function() {
      this.updateCountdown();
      this.interval = setInterval(this.updateCountdown, 1000);
    },
    componentWillUnmount: function() {
      clearInterval(this.updateCountdown);
    },
    calculateCountdown: function() {
      var countdown, date, diff, now, segment, segments, _i, _len;
      date = arguments[0], segments = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      countdown = {};
      now = moment();
      date = moment(date);
      for (_i = 0, _len = segments.length; _i < _len; _i++) {
        segment = segments[_i];
        diff = date.diff(now, 'milliseconds', true);
        countdown[segment] = Math.abs(Math.floor(moment.duration(diff).as(segment)));
        date = date.subtract(countdown[segment], segment);
      }
      return countdown;
    },
    updateCountdown: function() {
      var countdown;
      countdown = this.calculateCountdown.apply(this, [this.state.event.date].concat(__slice.call(this.state.segments)));
      this.setState({
        countdown: countdown
      });
    },
    render: function() {
      var classNames, segment, timerSegments, _i, _len, _ref;
      timerSegments = [];
      classNames = ['countdown--timer'].join(' ');
      _ref = this.state.segments;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        segment = _ref[_i];
        timerSegments.push(React.createElement(TimerSegment, {
          "key": segment,
          "name": segment,
          "data": this.state.countdown[segment]
        }));
      }
      return React.createElement(React.DOM.div, {
        "className": classNames
      }, React.createElement(React.DOM.h1, null, this.state.event.name), React.createElement(React.DOM.div, {
        "className": "countdown--timer_segments"
      }, timerSegments));
    }
  });

  TimerSegment = React.createClass({
    dataProperty: function(props) {
      var pad;
      pad = function(val, length, padChar) {
        var numPads;
        if (padChar == null) {
          padChar = '0';
        }
        val += '';
        numPads = length - val.length;
        if (numPads > 0) {
          return new Array(numPads + 1).join(padChar) + val;
        } else {
          return val;
        }
      };
      return pad(props.data, 2);
    },
    nameProperty: function(props) {
      if (props.data === 1) {
        return props.name.slice(0, -1);
      }
      return props.name;
    },
    render: function() {
      var dataClassName, propClassName, segmentClassName;
      segmentClassName = "timer--segment timer--segment_" + this.props.name;
      dataClassName = "timer--segment_data timer--segment_" + this.props.name + "_data";
      propClassName = "timer--segment_name timer--segment_" + this.props.name + "_name";
      return React.createElement(React.DOM.span, {
        "className": segmentClassName
      }, React.createElement(React.DOM.span, {
        "className": dataClassName
      }, this.dataProperty(this.props)), React.createElement(React.DOM.span, {
        "className": propClassName
      }, this.nameProperty(this.props)));
    }
  });

  React.renderComponent(React.createElement(Timer, null), document.getElementById('countdown-timer'));

}).call(this);

//# sourceMappingURL=Timer.js.map
