-- AUFK
 -- TRENN Auftraege
 -- 22.10.2012 Filter auf mandant_id in (1,2)
 -- 26.10.2011 system_id entfernt
 -- AUFK

-- AFKO
 -- , system_id
 -- AFKO statt COKO
 -- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 01.10.2019 TWIE: SPEC0045510 Auftragsart FL04 ergaenzt

-- 13.12.2019 TWIE: NSR1136156 auftrag_id -1 mit auftragsart_id -1 war doppelt aus Trenn- und Mischauftrag, deshalb bei Mischauftrag im Filter die -1 entfernt

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_auftrag (mandant_id, auftrag_id, auftragsart_id,
auftrag_bez, dat_start) AS SELECT V01.mandant_id,
 V01.auftrag_id,
 V01.auftragsart_id,
 V03.art_bez AS auftrag_bez,
 V02.dat_start
FROM kfl_production_dbp_view.v_flw_auftrag AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_auftrag_pps AS V02 ON V01.mandant_id = V02.mandant_id AND V01.auftrag_id = V02
   .auftrag_id -- MARM fuer MPA Texte

 LEFT JOIN kfl_production_dbp_view.v_flw_art_spr_zu AS V03 ON V01.mandant_id = V03.mandant_id AND V02.flw_art_id = V03.flw_art_id
   
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V04 ON V03.spr_id = V04.spr_id
WHERE V01.auftragsart_id IN ('FL02', 'FL04')
 AND V01.mandant_id IN (1, 2)
UNION ALL
SELECT V01.mandant_id,
 V01.auftrag_id,
 V02.auftragsart_id,
 V03.auftrag_bez,
 V01.dat_start
FROM kfl_production_dbp_view.v_flw_auftrag_pps AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_auftrag AS V02 ON V01.mandant_id = V02.mandant_id AND V01.auftrag_id = V02.auftrag_id
   -- COKO fuer TPA Texte

 INNER JOIN kfl_production_dbp_view.v_flw_trenn_auftrag AS V03 ON V01.mandant_id = V03.mandant_id AND V01.auftrag_id =
   V03.auftrag_id
WHERE V02.auftragsart_id IN ('ZPP1', '-1')
 AND V01.mandant_id IN (1, 2);