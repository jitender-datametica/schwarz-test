CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_F_ART_VZ_BEWKREIS_MONAT_2
(
mandant_id
,wup_id
,nb_id
,art_id
,gjmo
,preis_steuer_kz
,wrg_id
,gld
,standard_preis
,vz_menge_bestand_bme
,vz_wert_bestand
,vz_vk_wert
)
AS 
SELECT
t1.mandant_id                    as mandant_id
,t2.wup_id                           as wup_id
,t2.nb_id                              as nb_id
,t1.art_id                              as art_id
,t1.gjmo                               as gjmo
,t1.preis_steuer_kz              as preis_steuer_kz
,t1.wrg_id                            as wrg_id
,t1.gld                                  as gld
,t1.standard_preis                as standard_preis
,t1.menge_bestand_bme     as vz_menge_bestand_bme
,t1.wert_bestand                  as vz_wert_bestand
,t1.vk_wert                           as vz_vk_wert

FROM dbp_view.v_art_bewertungskreis_monat_2 t1_2

INNER JOIN dbp_view.v_wup_2 t2
ON t1.bewertungskreis_id = t2.bewertungskreis_id
AND t1.mandant_id = t2.mandant_id
WHERE t2.nb_id = -111
AND t1.mandant_id =1;