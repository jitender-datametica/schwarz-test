UPDATE DBP_DATA.wupcal

SET  datenlieferung_bonanzahl = 1
    ,bonanzahl = dt1.wert_
    ,td_update = CURRENT_TIMESTAMP

FROM
(       SELECT
        to_date(buchzeit ) dat_
        ,marktnummer AS wup_id_
        ,schluessel
        ,MAX(TO_NUMBER (INFO1 )) as wert_

        FROM DBP_ETL.gastro_finanz

        WHERE schluessel = 902
        GROUP BY 1,2,3
        
)dt1
WHERE   wup_id  = dt1.wup_id_
AND	dat     = dt1.dat_
AND     mandant_id = 1
AND     nb_id   = 2
;

