CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagertypgruppe_prompt AS SELECT mandant_id,
 lagernummer_id,
 lagertyp_id,
  CASE
  WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP',
    '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
  THEN 'A'
  WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id,
         'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08',
     '4G08')
  THEN 'G'
  WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
  THEN 'R'
  WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
  THEN 'E'
  ELSE 'S'
  END AS lagertypgruppe_id,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatik'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Griffzone'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Regal'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Sonstige'
  ELSE NULL
  END AS lagertypgruppe_bez_de,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatik'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Griffzone'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Regal'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Sonstige'
  ELSE NULL
  END AS lagertypgruppe_bez,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatic'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Picking Bin'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Rack'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Others'
  ELSE NULL
  END AS lagertypgruppe_bez_cz,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatic'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Picking Bin'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Rack'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Others'
  ELSE NULL
  END AS lagertypgruppe_bez_sk,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatic'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Picking Bin'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Rack'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Others'
  ELSE NULL
  END AS lagertypgruppe_bez_pl,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatic'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Picking Bin'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Rack'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Others'
  ELSE NULL
  END AS lagertypgruppe_bez_hr,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatic'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Picking Bin'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Rack'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Others'
  ELSE NULL
  END AS lagertypgruppe_bez_ro,
  CASE
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'A'
  THEN 'Automatic'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'G'
  THEN 'Picking Bin'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'R'
  THEN 'Rack'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'E'
  THEN 'Au\u00dfenlager'
  WHEN CASE
    WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP'
      , '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
    THEN 'A'
    WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id
           , 'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08'
       , '4G08')
    THEN 'G'
    WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
    THEN 'R'
    WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
    THEN 'E'
    ELSE 'S'
    END = 'S'
  THEN 'Others'
  ELSE NULL
  END AS lagertypgruppe_bez_bg
FROM kfl_production_dbp_view.v_l_lagertyp AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND wup_id > 0
 AND LENGTH(TRIM(lagernummer_id)) = 4
 AND CASE
   WHEN lagertyp_id IN ('3EAB', '3RAB', '4RAT', '4RAP', '4EAT', '4EAP', '4EHP', '4RHP', '4RHS', '1RAB', '1RAM', '1RAP',
     '1RHP', '1EHP', '5EHP', '5FHP', '5RHP')
   THEN 'A'
   WHEN (lagertyp_id IN ('3GAB', '4GAT', '4GAP', '4GHP', '1GAB', '1GHP', '5GHP', '5GH3', '5GH5') OR STRPOS(lagertyp_id,
          'G0') <> 0 OR STRPOS(lagertyp_id, 'G1') <> 0) AND LEFT(lagertyp_id, 1) <> 'R' AND lagertyp_id NOT IN ('3G08',
      '4G08')
   THEN 'G'
   WHEN STRPOS(lagertyp_id, 'R0') <> 0 OR STRPOS(lagertyp_id, 'R1') <> 0 AND RIGHT(lagertyp_id, 2) <> 'R1'
   THEN 'R'
   WHEN lagertyp_id IN ('1G43', '1G45', '1G55', '1R43', '1R53')
   THEN 'E'
   ELSE 'S'
   END <> 'S';