#scrape the table from html
$Global:SOURCE="C:\Powershell-Scrape-HTMLTable\example.html"
$Global:OUTPUT="C:\Powershell-Scrape-HTMLTable\tables.txt"
$website=Get-Content $SOURCE
$temp=@{}
$scrape=@{}
$i=0
$j=0
$collect=$False
$exception=$False
foreach($line in $website){
    if($collect -and $line -match "<table"){
        $exception=$True
    }
    if($line -match "<table"){#this is without > because sometimes there are parameters added to the open table marker
        $collect=$True
    }elseif($line -match "</table>" -and !$exception){
        $i++
        $j++
        $temp[$i]=$line
        $scrape[$j]=$temp
        $temp=@{}
        $collect=$False
    }elseif($line -match "</table>" -and $exception){
        $exception=$False
    }
    if($collect){
        $i++
        $temp[$i]=$line
    }
}
Out-File $OUTPUT
for($k=0; $k -le $scrape.Count; $k++){
    #foreach($line in $scrape[$k].Values){
    #    $line | Out-File $OUTPUT -Append
    #}
    #$scrape[$k].Values | Out-File $OUTPUT -Append
    for($x=0;$x -le $scrape[$k].Values.Count; $x++){
        if($scrape[$k] -ne $null) { 
            $scrape[$k][$x] | Out-File $OUTPUT -Append
        }
    }#$x++
}
