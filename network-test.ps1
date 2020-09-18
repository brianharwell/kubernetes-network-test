Write-Host "=> Start network test"

$sources = kubectl get pods --selector=networktest --output jsonpath='{range .items[*]}{.metadata.name} {.spec.nodeName}{\"\n\"}{end}'

foreach ($source in $sources) {
  $spod,$shost = $source.split(' ')
  $targets = kubectl get pods --selector=networktest --output jsonpath='{range .items[*]}{.status.podIP} {.spec.nodeName}{\"\n\"}{end}'
  foreach ($target in $targets) {
    $tip,$thost = $target.split(' ')
    kubectl exec $spod -- dotnet KubernetesNetworkTest.Console.dll http://$tip | Out-Null;
    if ($LASTEXITCODE -ne 0) {
      Write-Host "$shost cannot reach $thost" -ForegroundColor Red
    }
    else {
      Write-Host "$shost can reach $thost" -ForegroundColor Green
    }
  }
}

Write-Host "=> End network overlay test"
