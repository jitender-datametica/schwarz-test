CREATE OR REPLACE VIEW materialisierung.mv_immo_wsa_kpi_2 AS WITH MOMESS AS (SELECT WE.mandant_id,
   WE.region_id,
   WE.we_intreno,
   MV.mv_intreno,
    CASE
    WHEN MV.branche_id <> 0
    THEN MV.branche_id
    ELSE MO.branche_id
    END AS branche_id,
   SUM(MM.groesse) AS groesse
  FROM kfl_production_dbp_view.v_immo_wirtschaftseinheit_2 AS WE
   INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_2 AS MO ON WE.mandant_id = MO.mandant_id AND WE.we_intreno = MO.we_intreno
     
   INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_messung_2 AS MM_2 ON MO.mandant_id = MM.mandant_id AND MO.mo_intreno
      = MM.mo_intreno
   INNER JOIN kfl_production_dbp_msi_view_immo.mv_we_mo_mv_zu_2 AS WMM ON WE.mandant_id = WMM.mandant_id AND WE.we_intreno
       = WMM.we_intreno AND MO.mo_intreno = WMM.mo_intreno
   INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_2 AS MV ON WE.mandant_id = MV.mandant_id AND WMM.mv_intreno =
     MV.mv_intreno
  WHERE CAST('CURRENT_DATE' AS DATE) BETWEEN WE.dat_we_gueltig_von AND WE.dat_we_gueltig_bis
   AND CAST('CURRENT_DATE' AS DATE) BETWEEN MM.dat_von AND MM.dat_bis
   AND MM.bemessung_art_id IN ('0300', '0310', '0320', '0380')
  GROUP BY WE.mandant_id,
   WE.region_id,
   WE.we_intreno,
   MV.mv_intreno,
   branche_id) (SELECT WSA.mandant_id,
   COALESCE(CASE
     WHEN WSA.mandant_id = 1
     THEN LPAD(TRIM(WSA.region_id), 2, '0')
     ELSE momess.region_id
     END, 'n.v.') AS region_id,
   momess.we_intreno,
   momess.mv_intreno,
   momess.branche_id,
   MWT.wrg_id,
   MWT.wrg_typ_id,
   momess.groesse,
    CASE
    WHEN MWT.wrg_typ_id = 0
    THEN WSA.umsatz_produktivitaet * LW.umrechnungskurs
    ELSE WSA.umsatz_produktivitaet
    END AS umsatz_produktivitaet,
    CASE
    WHEN MWT.wrg_typ_id = 0
    THEN WSA.kunde_umsatz * LW.umrechnungskurs
    ELSE WSA.kunde_umsatz
    END AS kunde_umsatz
  FROM kfl_production_dbp_view.v_immo_wsa_kpi_2 AS WSA
   INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS MWT ON WSA.mandant_id = MWT.mandant_id
   INNER JOIN kfl_production_dbp_view.v_mandant_2 AS M ON WSA.mandant_id = M.mandant_id
   INNER JOIN kfl_production_dbp_view.v_kurs_2 AS LW ON M.default_wrg = LW.von_wrg_id AND LW.nach_wrg_id = 'EUR' AND LW.kurstyp_id
       = 3 AND LW.dat_bis = DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_groesse_kategorie_2 AS GKAT ON WSA.groesse_kategorie = GKAT.groesse_kategorie
    
   INNER JOIN MOMESS AS momess ON WSA.mandant_id = momess.mandant_id AND CASE
         WHEN WSA.mandant_id = 1
         THEN LPAD(TRIM(WSA.region_id), 2, '0')
         ELSE 'Dummy_2'
         END = CASE
         WHEN WSA.mandant_id = 1
         THEN momess.region_id
         ELSE 'Dummy_2'
         END AND WSA.branche_id = momess.branche_id AND GKAT.groesse_von <= momess.groesse AND GKAT.groesse_bis >=
     momess.groesse);