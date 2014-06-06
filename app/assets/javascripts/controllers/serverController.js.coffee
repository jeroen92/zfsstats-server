@ServerCtrl = ($scope, $routeParams, Server) ->
  $scope.warning = false;
  $scope.zpools = [];
  $scope.capacity = Number(0);
  
  Server.get serverId: $routeParams.serverId, (server) ->
    $scope.server = server
    angular.forEach $scope.server.devices, (device, deviceIndex) ->
      if angular.lowercase(device.device.type) == 'zfs'
        $scope.zfs = $scope.server.devices[deviceIndex].device
      else if angular.lowercase(device.device.type) == 'zpool'
        $scope.zpools.push($scope.server.devices[deviceIndex].device)
        $scope.zpools.slice(-1)[0].pct = ((parseInt(device.device.used) / parseInt(device.device.capacity)) * 100)
        if device.device.state != 'ONLINE'
            $scope.warning = true
        $scope.capacity += Number(device.device.capacity) / 1000000000000
  
  $scope.editDescriptionVisible = false;

  $scope.showPoolListing = false;

  $scope.listZpools = ->
	  $scope.showPoolListing = !$scope.showPoolListing
