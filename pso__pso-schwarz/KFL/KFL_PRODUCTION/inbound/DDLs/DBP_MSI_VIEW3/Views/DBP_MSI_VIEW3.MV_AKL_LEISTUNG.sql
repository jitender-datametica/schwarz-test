CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_AKL_LEISTUNG 
-- 13.05.2021, AP0070892, SPEC0086902, dknop, initial
AS 
SELECT 
 mandant_id
,lagernummer_id
,wup_id
,nb_id
,dat
,stunde
,lagertyp_id
,meldepunkt
,warenbewegungstyp_id
,lager_einheiten_typ
,menge_lbs_lvs_palette
,menge_lbs_lvs_kolli
FROM DBP_VIEW.V_AKL_LEISTUNG;