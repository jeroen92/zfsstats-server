@ServerJobsController = ($scope, $routeParams, $modal, Server, Job, JobReport) ->

	Server.get serverId: $routeParams.serverId, (server) ->
		$scope.server = server

	Job.query server_id: $routeParams.serverId, (jobs) ->
		angular.forEach jobs, (job, jobIndex) ->
			if job._type == 'MeasurementJob'
				$scope.measurementJob = job
				yesterday = new Date()
				yesterday.setDate yesterday.getDate() - 1
				JobReport.query job_id: job.id, status: 1, start: yesterday.toISOString(), (reports) ->
					$scope.measurementJob.alerts1D = reports
				yesterday.setDate yesterday.getDate() - 6
				JobReport.query job_id: job.id, status: 1, start: yesterday.toISOString(), (reports) ->
					$scope.measurementJob.alerts1W = reports
				JobReport.query job_id: job.id, status: 1, (reports) ->
					$scope.measurementJob.alertsInfinite = reports

	$scope.toggleMeasurementActive = ->
		$scope.measurementJob.status = !$scope.measurementJob.status
		Job.update serverId: $routeParams.serverId, jobId: $scope.measurementJob.id, $scope.measurementJob

	$scope.openEditMeasurementModal = ->
		modalInstance = $modal.open (
			templateUrl: '/assets/modals/editMeasurementJob.html',
			controller: ($scope, $routeParams, $modalInstance, measurementJob, Job) ->
				$scope.measurementJob = angular.copy(measurementJob)
				$scope.measurementJob.interval /= 60
				$scope.cancel = ->
					$modalInstance.dismiss('cancel')
				$scope.save = ->
					return if isNaN $scope.measurementJob.interval
					measurementJob.interval = $scope.measurementJob.interval * 60
					measurementJob.status = $scope.measurementJob.status
					Job.update serverId: $routeParams.serverId, jobId: measurementJob.id, measurementJob
					$modalInstance.dismiss('cancel')
			resolve:
				measurementJob: ->
					return $scope.measurementJob
		)