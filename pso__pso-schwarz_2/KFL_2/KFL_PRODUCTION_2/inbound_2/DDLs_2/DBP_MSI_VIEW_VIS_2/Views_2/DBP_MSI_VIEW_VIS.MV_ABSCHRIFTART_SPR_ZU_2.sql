CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_SPR_ZU_2
AS
   --SPRACHE Abschriftart (National)
   --2011KW37: Initial Abschriftart + Internationaliserung (feste Sprache)
   --2015KW46: Erweiterung um alle Abschriftarten, für Mehrsprachigkeit im CUBE
   --2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   --2017.0221 : Update (Abschriftart Int)

   SELECT
   v01.mandant_id, v01.abschriftart_id, /*Conversion issue - Severity Medium - 'abschriftart_bez_de' has recursive references. Forward alias conversion could not be completed*/
     MAX(CASE WHEN spr_id =  22 THEN abschriftart_bez ELSE 'AKZ ' || TRIM(v01.abschriftart_id) END) AS abschriftart_bez_de ,
 abschriftart_bez_de                                                                  AS abschriftart_bez     -- default (DE)
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN abschriftart_bez END), /*Conversion issue - Severity Medium - 'abschriftart_bez_de' has recursive references. Forward alias conversion could not be completed*/
 abschriftart_bez_de) AS abschriftart_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN abschriftart_bez END), /*Conversion issue - Severity Medium - 'abschriftart_bez_de' has recursive references. Forward alias conversion could not be completed*/
 abschriftart_bez_de) AS abschriftart_bez_sk  -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN abschriftart_bez END), /*Conversion issue - Severity Medium - 'abschriftart_bez_de' has recursive references. Forward alias conversion could not be completed*/
 abschriftart_bez_de) AS abschriftart_bez_hr  -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN abschriftart_bez END), /*Conversion issue - Severity Medium - 'abschriftart_bez_de' has recursive references. Forward alias conversion could not be completed*/
 abschriftart_bez_de) AS abschriftart_bez_pl  -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN abschriftart_bez END), /*Conversion issue - Severity Medium - 'abschriftart_bez_de' has recursive references. Forward alias conversion could not be completed*/
 abschriftart_bez_de) AS abschriftart_bez_ro  -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN abschriftart_bez END), /*Conversion issue - Severity Medium - 'abschriftart_bez_de' has recursive references. Forward alias conversion could not be completed*/
 abschriftart_bez_de) AS abschriftart_bez_bg  -- BG
   -- DE

   FROM dbp_view.v_abschriftart_spr_zu_2  v01

   GROUP BY 1,2
   ;