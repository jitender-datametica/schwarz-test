DELETE FROM dbp_ods.ods_bon_agg_15min
WHERE 
mandant_id = 6 AND 
(
(wup_id = 4730 AND dat = '2021-10-10')
OR
(wup_id in (2730,2930) AND dat = '2021-10-11')
);


INSERT INTO dbp_ods.ods_bon_agg_15min
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug_okf
   ,td_insert
   ,td_update
)
SELECT
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
   ,CURRENT_TIMESTAMP
   ,CURRENT_TIMESTAMP
FROM dbp_etl.ods_bon_15min_agg_20211129
WHERE 
mandant_id = 6 AND 
(
(wup_id = 4730 AND dat = '2021-10-10')
OR
(wup_id in (2730,2930) AND dat = '2021-10-11')
);
