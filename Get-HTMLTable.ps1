#scrape the table from html
$Global:SOURCE="C:\temp\example.html"
$Global:OUTPUT="C:\temp\tables.txt"
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
    if($line -match "<table" -and !$exception){#this is without > because sometimes there are parameters added to the open table marker
        $collect=$True
    }elseif($line -match "</table>" -and $exception){
        $exception=$False
        #$i++
        #$j++
        #$temp[$i]=$line
    }elseif($line -match "</table>" -and !$exception){
        $i++
        $j++
        $temp[$i]=$line
        $scrape[$j]=$temp
        $temp=@{}
        $collect=$False
    }
    if($collect){
        $i++
        $temp[$i]=$line
    }
}
Out-File $OUTPUT
$x=0
$a=0
for($k=0; $k -le $scrape.Count; $k++){
    #foreach($line in $scrape[$k].Values){
    #    $line | Out-File $OUTPUT -Append
    #}
    #$scrape[$k].Values | Out-File $OUTPUT -Append
    $a=$a+$scrape[$k].Values.Count
    for($x=0; $x -le $a; $x++){
        if($scrape[$k] -ne $null) { 
            $scrape[$k][$x] | Out-File $OUTPUT -Append
        }
    }
    "____________________" | Out-File $OUTPUT  -Append #linebreak between table blocks
}
