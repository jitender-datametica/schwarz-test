CREATE OR REPLACE VIEW DBP_VIEW.V_IMS_STANDORT AS 
    SELECT 
        mandant_id
        ,standort_id
        ,wup_id
        ,nb_id
        ,standort_name
        ,dat_eroeffnung
        ,eigentum_kz
        ,umzugsfiliale_fg
        ,neu_standort_fg
        ,ginfo_markt_typ
        ,umsatz_ea
        ,verkaufsflaeche
        ,konzessionaersflaeche
        ,betriebsflaeche
        ,sparte_id
        ,datenquelle_kz
        ,wrg_id


FROM DBP_DATA.ims_standort ;