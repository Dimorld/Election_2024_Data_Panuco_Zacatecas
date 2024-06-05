#! /usr/bin/awk -f

BEGIN{

    OFS=FS="|"
    
}

NR==1 {
    for (inFldNr=4; inFldNr<=NF; inFldNr++) {
        fldName = $inFldNr
        if ( !(fldName in fldName2outFldNr) ) {
            outFldNr2name[++numOutFlds] = fldName
            fldName2outFldNr[fldName] = numOutFlds
        }
        outFldNr = fldName2outFldNr[fldName]
        out2inFldNrs[outFldNr,++numInFlds[outFldNr]] = inFldNr
    }

    printf "%s%s", $1"|"$2"|"$3, OFS
    for (outFldNr=1; outFldNr<=numOutFlds; outFldNr++) {
        outFldName = outFldNr2name[outFldNr]
        printf "%s%s", outFldName, (outFldNr<numOutFlds ? OFS : ORS)
    }
    next
}
{
    printf "%s%s",$1"|"$2"|"$3 , OFS
    for (outFldNr=1; outFldNr<=numOutFlds; outFldNr++) {
        sum = 0
        for (inFldIdx=1; inFldIdx<=numInFlds[outFldNr]; inFldIdx++) {
            inFldNr = out2inFldNrs[outFldNr,inFldIdx]
            sum += $inFldNr
        }
        printf "%s%s", sum, (outFldNr<numOutFlds ? OFS : ORS)
    }
}
