CREATE VOLATILE TABLE _gp_unique AS (
SELECT a.*,
       CASE
         WHEN (mandant_id = 2 AND einkaufsorganisation_id = 1000) OR
              (mandant_id = 3 AND einkaufsorganisation_id = 1060) OR
              (mandant_id = 4 AND einkaufsorganisation_id = 1040) OR
              (mandant_id = 5 AND einkaufsorganisation_id = 1020) OR
              (mandant_id = 6 AND einkaufsorganisation_id = 1030) OR
              (mandant_id = 7 AND einkaufsorganisation_id = 1070) OR
              (mandant_id = 8 AND einkaufsorganisation_id = 1090)
         THEN 0
         ELSE 1
       end AS sort_fld
FROM ${TEMP_TABLE} a
QUALIFY row_number() over (partition by mandant_id,gp_id order by sort_fld,einkaufsorganisation_id) = 1
);

UPDATE dbp_data.gp SET min_pal_faktor_lkw        = _min_pal_faktor_lkw
                      ,zahlungsziel_id           = _zahlungsziel_id
                      ,zek_id                    = _zek_id
                      ,einkaufsorganisation_id   = _einkaufsorganisation_id
                      ,lieferzeit                = _lieferzeit
                      ,hgp_id                    = _hgp_id
FROM (SELECT
     mandant_id                as _mandant_id
    ,gp_id                     as _gp_id
    ,einkaufsorganisation_id   as _einkaufsorganisation_id
    ,hgp_id                    as _hgp_id
    ,zek_id                    as _zek_id
    ,lieferzeit                as _lieferzeit
    ,zahlungsziel_id           as _zahlungsziel_id
    ,min_pal_faktor_lkw        as _min_pal_faktor_lkw
FROM _gp_unique) t1
WHERE mandant_id                = _mandant_id
  AND gp_id                     = _gp_id
;

CREATE VOLATILE TABLE _md_killing AS (
SELECT gp_id
FROM _gp_unique
WHERE mandant_id IN (4,7) and
      gp_id <> 6100
GROUP BY 1
HAVING COUNT(*) > 1
);

DELETE FROM DBP_DATA.gp
WHERE mandant_id = 7 AND
      gp_id IN (SELECT gp_id FROM _md_killing)
;
