@DashboardController = ($scope, $routeParams, $timeout, Device, User, Server, Job, JobReport, Measurement) ->
  $scope.devicesUp = 0
  $scope.userId = userId
  Device.query type: 'zpool', (devices) ->
  	angular.forEach devices, (device, deviceIndex) ->
  		if device.state == 'ONLINE'
  			$scope.devicesUp += 1
  	$scope.devices = devices

  User.query (users) ->
  	$scope.users = users

  Server.query limit: 4, order: 'desc', order_by: 'status', (servers) ->
    $scope.servers = servers

  yesterday = new Date()
  yesterday.setDate yesterday.getDate() - 1
  JobReport.query start: yesterday.toISOString(), status: 1, (jobReports) ->
    $scope.jobReportAlert24H = jobReports.length

  yesterday.setDate yesterday.getDate() - 6
  JobReport.query start: yesterday.toISOString(), status: 1, (jobReports) ->
    $scope.jobReportAlert7D = jobReports.length

  lastHour = new Date()
  lastHour.setHours(lastHour.getHours() - 1)

  loadSummary = ->
    randomMeasurementValue = 0
    measurementNames = ['bytesRead', 'bytesWrite', 'bytesReadL2arc', 'bytesWriteL2arc']
    if $scope.randomMeasurementIndex
      $scope.randomMeasurementIndex++
      $scope.randomMeasurementIndex = $scope.randomMeasurementIndex % measurementNames.length
    else
      $scope.randomMeasurementIndex = Math.floor(Math.random() * measurementNames.length)
    Measurement.query name: measurementNames[$scope.randomMeasurementIndex], (measurements) ->
      angular.forEach measurements, (measurement, measurementIndex) ->
        $scope.randomMeasurementName = measurement.name
        Measurement.get measurementId: measurement.id, start: lastHour.toISOString(), (measurementData) ->
          if measurement.is_cumulative
            randomMeasurementValue += (measurementData.data[measurementData.data.length-1][1] - measurementData.data[0][1])
          else
            angular.forEach measurementData.data, (data, dataIndex) ->
              randomMeasurementValue += data[1]
          $scope.randomMeasurementValue = randomMeasurementValue
    $timeout(loadSummary, 8000)
  loadSummary()

  $scope.gotoServer = (serverId) ->
    window.location = '/servers/' + serverId

  $scope.gotoUser = (userId) ->
    window.location = '/users/' + userId + '/edit'