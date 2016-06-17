###

Materia
It's a thing

Widget: Radar Grapher, Engine
Authors: Ivey Padgett

###
RadarGrapher = angular.module 'RadarGrapherEngine', ['ngMaterial', 'chart.js']

RadarGrapher.config ['ChartJsProvider', (ChartJsProvider) ->
		ChartJsProvider.setOptions {
			colours: ['#ff4081']
			scaleOverride: true
			scaleSteps: 5
			scaleStepWidth: 20
			scaleStartValue: 0 # The chart is always from 0 to 100
			scaleShowLine: false
			pointLabelFontSize: 15
			pointLabelFontStyle: 'bold'
			pointDotRadius: 2
			pointDotStrokeWidth: 0.1
			responsive: false
			angleLineWidth : 8
			angleLineColor: '#d5d5d5'
		}
	]

RadarGrapher.controller 'RadarGrapherEngineCtrl', ['$scope', ($scope) ->
	$scope.inProgress = true

	$scope.qset = null
	$scope.instance = null
	$scope.responses = []

	# Chart data. Includes the labels.
	# The chart can handle more than one set of data, but we will only use one.

	$scope.data = [[]]
	$scope.labels = []

	$scope.start = (instance, qset, version) ->
		$scope.instance = instance
		$scope.qset = qset
		populateLabels()
		$scope.$apply()

	populateLabels = ->
		for question in $scope.qset.items
			$scope.labels.push question.options.label

	$scope.submit = ->
		_padResponses()
		$scope.data[0] = $scope.responses

		# Change the screen from questions to chart
		$scope.inProgress = false

	# Add 20 to each response to make room for the circle in the center of the graph.
	_padResponses = ->
		for response, i in $scope.responses
			# $scope.responses[i] = if response < 90 then response + 10 else response
			$scope.responses[i] = Math.floor($scope.responses[i] * 0.8) + 10


	$scope.$on 'create', (evt, chart) ->

		radar = document.getElementById 'radar'

		wheel = document.getElementById 'outer-wheel'

		radarWidth = 800
		radarHeight = 500

		wheel.width = radarWidth
		wheel.height = radarHeight

		ctx = wheel.getContext '2d'
		ctx.fillStyle = '#d5d5d5'
		ctx.strokeStyle = '#d5d5d5'
		ctx.beginPath()
		ctx.lineWidth = 20

		ctx.arc (radarWidth / 2), (radarHeight / 2), 218, 0, 2 * Math.PI
		ctx.stroke()

		ctx.beginPath()
		ctx.arc (radarWidth / 2), (radarHeight / 2), 20, 0, 2 * Math.PI
		ctx.fill()


	Materia.Engine.start($scope)
]


RadarGrapher.controller 'PrintController', ['$scope', ($scope) ->

]