#scrape the table from html

$website=Get-Content "path"

$temp=@{}

$scrape=@{}

$i=0

$j=0

$collect=$False

foreach($line in $website){

    #$temp=@{}

    if($line -match "<table" -and $collect){

        $temp=@{}

        $collect=$False

    }

    if($line -match "<table"){

        #amount of close table tag means we really have that many

        $collect=$True

        $temp[$i]=$line

    }elseif($line -match "</table>"){

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
