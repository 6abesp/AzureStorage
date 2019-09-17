Connect-AzAccount

#guardar todas las subscripciones
$Subs=Get-AzSubscription

$path = read-host "coloca una direccion en tu equipo"  

Add-Content -Path  $path  -Value '"ID","NombreVM","ResourceGroup","subscripcion", "Tamaño","tipo"'


foreach($Sub in $Subs)
{
 Set-AzureRmContext -SubscriptionId $Sub.Id
#Get-AzureRmContext

##Obtener todas las máquinas virtuales

$stors =  Get-AzureRmStorageAccount

#Obtener todas las interfaces de red

$idnum=1
foreach($stor in $stors)
    { 
    $name=$stor.StorageAccountName
    $rg =$stor.ResourceGroupName
    $zs = $stor.SkuName
    $kind=$stor.kind
    $id = $stor.Id
 #imprimir
    $print = @(" $name ,$rg,$($Sub.Name),$zs,$kind,$id " ) 
    $idnum++
    $print | foreach { Add-Content -Path $path -Value $_ }

    }
 }