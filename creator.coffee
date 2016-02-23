###

Materia
It's a thing

Widget: Radar Grapher, Creator
Author: Ivey Padgett
Updated: 1/20/2016

###

# Create an angular module to house our controller
RadarGrapher = angular.module 'RadarGrapherCreator', ['ngMaterial', 'chart.js']

RadarGrapher.controller 'RadarGrapherController', ['$scope', ($scope) ->
	$scope.widgetTitle = "My Radar Grapher Widget"

	$scope.data = {
		labels: []
		datasets: []
	}

	# Input data for each question. Start with samples of 3.
	$scope.cards = [
		{
			'question': 'Question 1'
			'label': 'Label 1'
			'min': 'Min 1'
			'max': 'Max 1'
		}
		{
			'question': 'Question 2'
			'label': 'Label 2'
			'min': 'Min 2'
			'max': 'Max 2'
		}
		{
			'question': 'Question 3'
			'label': 'Label 3'
			'min': 'Min 3'
			'max': 'Max 3'
		}
	]

	populateData = ->
		dataArr = []
		for card in $scope.cards
			$scope.data.labels.push card.label
			dataArr.push 0
		$scope.data.datasets.push {
			fillColor: "rgba(255,64,129, 0.5)"
			data: dataArr
		}

	populateData()

	# Add new	questions when the plus button is clicked as long as there are
	# less than 10 questions.
	$scope.addQuestion = ->
		if $scope.cards.length >= 10
			return

		newIndex = $scope.cards.length + 1
		$scope.cards.push {}
		$scope.data.labels.push ""
		$scope.data.datasets[0].data.push 0

	$scope.updateLabels = (index, label) ->
		$scope.data.labels[index] = label

	Materia.CreatorCore.start $scope
]

RadarGrapher.directive 'ngCircle', ->
	return {
		restrict: 'A'
		link: (scope, ele, attr) ->
			canvas = ele[0]
			ctx = canvas.getContext('2d')

			chartOptions = {
				scaleOverride: true
				scaleSteps: 5
				scaleStepWidth: 20
				scaleStartValue: 0 # The chart is always from 0 to 100
				scaleShowLine: false
				pointLabelFontSize: 20
			}

			myChart = new Chart(ctx).Radar(scope.data, chartOptions)

			scope.$watch('data', () ->
				if myChart?
					myChart.destroy()
					cnv = '<canvas id="radar" class="chart" ng-circle></canvas>'
					document.getElementById("chartContainer").innerHTML = cnv
					ctx = document.getElementById("radar").getContext('2d')
					myChart = new Chart(ctx).Radar(scope.data, chartOptions)
			, true)
	}

RadarGrapher.config ($mdThemingProvider) ->
	$mdThemingProvider.theme('toolbar-dark', 'default')
		.primaryPalette('indigo')
		.dark()
