SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM DBP_DATA.wup
,
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
AND wup_standort <> wup_standort_

--end subquery

);

