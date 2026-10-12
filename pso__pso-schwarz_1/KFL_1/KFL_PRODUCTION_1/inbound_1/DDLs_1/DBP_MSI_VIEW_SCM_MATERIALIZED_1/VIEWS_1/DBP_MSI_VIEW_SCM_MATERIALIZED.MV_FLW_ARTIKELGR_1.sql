create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SCM_MATERIALIZED.MV_FLW_ARTIKELGR_1(
	MANDANT_ID,
	ART_ID,
	ART_GRUPPE_ID,
	ART_GRUPPE_BEZ,
	ART_KLASSE_ID,
	ART_KLASSE_BEZ,
	ART_ROHSTOFF_ID,
	ART_ROHSTOFF_BEZ
) as
   
   /*  2020-12-04  nwag2310 alte Version auf persitente Tabelle umgestellt

   SELECT
  --2020-04-30 bugfix switch artikelklasse/rohstoff_1
  t2.mandant_id,
   t2.art_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL001' THEN t0.art_attribut_id ELSE '-' END) AS art_gruppe_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL001' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_gruppe_bez,
   MAX(CASE WHEN t0.art_gruppe_id='FL003' THEN t0.art_attribut_id ELSE '-' END) AS art_klasse_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL003' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_klasse_bez,
   MAX(CASE WHEN t0.art_gruppe_id='FL002' THEN t0.art_attribut_id ELSE '-' END) AS art_rohstoff_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL002' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_rohstoff_bez

   FROM dbp_view.v_art_1 t2
   LEFT JOIN dbp_view.v_art_gruppe_attribut_zu_1 t0
   ON t2.mandant_id=t0.mandant_id
   AND t2.art_id=t0.art_id
   LEFT JOIN dbp_view.v_art_attribut_spr_zu_1 t1_1
   ON t0.art_attribut_id=t1.art_attribut_id

   WHERE t2.loesch_id <> 'L'

   GROUP BY 1,2;

   */

select v0.mandant_id                    
,v0.art_id                        
,v0.art_gruppe_id                 
,v0.art_gruppe_bez                
,v0.art_klasse_id                 
,v0.art_klasse_bez                
,v0.art_rohstoff_id               
,v0.art_rohstoff_bez              
 from dbp_view.v_art_art_gruppe_flw_1 v0;
 