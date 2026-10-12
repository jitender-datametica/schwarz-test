DELETE 
FROM dbp_data.wup_wetter_tag wfc
USING dbp_data.wup w
WHERE wfc.mandant_id = w.mandant_id
     AND wfc.wup_id = w.wup_id
     AND wfc.dat > w.dat_bis
     AND w.wup_id <> w.aktuell_wup_id
;
