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
