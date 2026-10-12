UPDATE DBP_DATA.wup
SET wup_standort = wup_standort_

FROM
(SELECT
         mandant_id                     AS mandant_id_
        ,wirtschaftseinheit_id          AS wup_id_
        ,Min(wirtschaftseinheit_bez)    AS wup_standort_
FROM DBP_DATA.immo_wirtschaftseinheit 
WHERE dat_we_gueltig_bis = to_date('9999-12-31','YYYY-MM-DD')
GROUP BY 1,2
)a

WHERE
    mandant_id   = mandant_id_
AND wup_id       = wup_id_
;

-- dbay, 23.01.2024
update dbp_data.wup set wup_standort = 'Waiblingen, RemsPark'
where mandant_id = 1 and
      wup_id = 4853
;
