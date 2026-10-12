CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_LAGEFAKTOR_1 as
   SELECT
   marm.mandant_id,
   marm.art_id,
   max(marm.umrech_zaehler/marm.umrech_nenner) as lagefaktor
   FROM dbp_view.v_art_umrechnung_faktor_per_1 marm_1
   LEFT OUTER JOIN dbp_view.v_art_vorschlagswert_per_1 maw1_1
   ON marm.mandant_id=maw1.mandant_id and marm.art_id=maw1.art_id and marm.dat_bis=maw1.dat_bis
   WHERE marm.dat_bis='9999-12-31'
   AND
   --DE
   (marm.mandant_id=1 AND marm.altnv_menge_einh_id=maw1.lage_faktor_einh_id )
   OR
   --Ausland
   (marm.mandant_id<>1 AND marm.altnv_menge_einh_id in ('VST','LAG'))
   GROUP BY 1,2;