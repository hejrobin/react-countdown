# @cjsx React.DOM
Timer = React.createClass

  getInitialState: () ->
    el = $('#countdown-timer')
    date = el.data 'event-date'
    name = el.data 'event-name'
    segments = el.data('segments').split ','
    args = [date].concat segments
    countdown = @calculateCountdown args...

    segments: segments
    countdown: countdown
    event:
      name: name
      date: date

  componentDidMount: () ->
    do @updateCountdown
    @interval = setInterval @updateCountdown, 1000
    return

  componentWillUnmount: () ->
    clearInterval @updateCountdown
    return

  calculateCountdown: (date, segments...) ->
    countdown = {}
    now = do moment
    date = moment date

    for segment in segments
      diff = date.diff now, 'milliseconds', yes
      countdown[segment] = Math.abs Math.floor moment.duration(diff).as segment
      date = date.subtract countdown[segment], segment

    countdown

  updateCountdown: () ->
    countdown = @calculateCountdown @state.event.date, @state.segments...
    @setState countdown: countdown
    return

  render: () ->
    timerSegments = []
    classNames = [ 'countdown--timer' ].join ' '

    for segment in @state.segments
      timerSegments.push(
        <TimerSegment
          key={segment}
          name={segment}
          data={@state.countdown[segment]}
        />
      )

    <div className={classNames}>
      <h1>{@state.event.name}</h1>
      <div className="countdown--timer_segments">
        {timerSegments}
      </div>
    </div>

# @cjsx React.DOM
TimerSegment = React.createClass

  dataProperty: (props) ->
    pad = (val, length, padChar = '0') ->
      val += ''
      numPads = length - val.length
      if (numPads > 0) then new Array(numPads + 1).join(padChar) + val else val

    pad props.data, 2

  nameProperty: (props) ->
    if props.data is 1
      return props.name.slice(0, -1)
    props.name

  render: () ->
    segmentClassName = "timer--segment timer--segment_#{@props.name}"
    dataClassName = "timer--segment_data timer--segment_#{@props.name}_data"
    propClassName = "timer--segment_name timer--segment_#{@props.name}_name"

    <span className={segmentClassName}>
      <span className={dataClassName}>{ @dataProperty @props }</span>
      <span className={propClassName}>{ @nameProperty @props }</span>
    </span>

# @cjsx React.DOM
React.renderComponent <Timer />, document.getElementById 'countdown-timer'
