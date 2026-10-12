CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_cost_sapbw_logistics_2 AS SELECT CASE
  WHEN COALESCE(TRIM(LJ.inat_account_number2), TRIM(VJ.inat_account_number2)) IN ('307K865200', '307K857120',
     '3403360000', '3406110000', '3406130000', '3406110000', '3406130000', '3408130000', '3408140000', '3408220000') OR
    COALESCE(LJ.corporate_division_id, VJ.corporate_division_id) = 'G'
  THEN 'Y'
  ELSE 'N'
  END AS warehouse_reporting_data,
 COALESCE(LJ.business_year, VJ.business_year + 1) AS business_year,
 COALESCE(LJ.booking_month, VJ.booking_month + 100) AS booking_month,
 COALESCE(LJ.corporate_division_id, VJ.corporate_division_id) AS corporate_division_id,
 COALESCE(LJ.corporate_division_desc, VJ.corporate_division_desc) AS corporate_division_desc,
 COALESCE(LJ.warehouse_nr, VJ.warehouse_nr) AS warehouse_nr,
 COALESCE(LJ.warehouse_desc_short, VJ.warehouse_desc_short) AS warehouse_desc_short,
 COALESCE(LJ.warehouse_desc, VJ.warehouse_desc) AS warehouse_desc,
 COALESCE(LJ.cost_center, VJ.cost_center) AS cost_center,
 COALESCE(LJ.referencekey, VJ.referencekey) AS referencekey,
 COALESCE(LJ.cost_category, VJ.cost_category) AS cost_category,
 COALESCE(LJ.nat_account_type, VJ.nat_account_type) AS nat_account_type,
 COALESCE(LJ.nat_account_number, VJ.nat_account_number) AS nat_account_number,
 COALESCE(LJ.nat_account_desc, VJ.nat_account_desc) AS nat_account_desc,
 COALESCE(LJ.inat_account_number2, VJ.inat_account_number2) AS inat_account_number2,
 COALESCE(LJ.inat_account_desc2, VJ.inat_account_desc2) AS inat_account_desc2,
 COALESCE(LJ.inat_account_number, VJ.inat_account_number) AS inat_account_number,
 COALESCE(LJ.inat_account_desc, VJ.inat_account_desc) AS inat_account_desc,
 SUM(LJ.value_costs) AS costs_lj,
 SUM(VJ.value_costs) AS costs_vj
FROM (SELECT business_year,
   booking_month,
   corporate_division_id,
   corporate_division_desc,
    CASE
    WHEN warehouse_desc_short = 'HEE'
    THEN 1
    WHEN warehouse_desc_short = 'ETT'
    THEN 2
    WHEN warehouse_desc_short = 'OOS'
    THEN 3
    WHEN warehouse_desc_short = 'ZWA'
    THEN 4
    WHEN warehouse_desc_short = 'WEE'
    THEN 5
    WHEN warehouse_desc_short = 'WAD'
    THEN 6
    ELSE 9
    END AS warehouse_nr,
    CASE
    WHEN warehouse_desc_short NOT IN ('HEE', 'ETT', 'OOS', 'ZWA', 'WEE', 'WAD', 'TIE')
    THEN 'TIE'
    ELSE warehouse_desc_short
    END AS warehouse_desc_short,
    CASE
    WHEN warehouse_desc_short NOT IN ('HEE', 'ETT', 'OOS', 'ZWA', 'WEE', 'WAD', 'TIE')
    THEN 'Tiel'
    ELSE warehouse_desc
    END AS warehouse_desc,
   cost_center,
   referencekey,
   cost_category,
    CASE
    WHEN STRPOS(UPPER(nat_account_desc), 'KALK') <> 0
    THEN 'Gecalculeerd'
    ELSE 'Gefactureerd'
    END AS nat_account_type,
   nat_account_number,
   nat_account_desc,
   inat_account_number2,
   inat_account_desc2,
   inat_account_number,
   inat_account_desc,
   SUM(value_costs) AS value_costs
  FROM ldl_s_conl_workbench.t_i_cost_sapbw_logistics_2
  WHERE business_year = 2021
  GROUP BY business_year,
   booking_month,
   corporate_division_id,
   corporate_division_desc,
   warehouse_nr,
   t_i_cost_sapbw_logistics.warehouse_desc_short,
   warehouse_desc,
   cost_center,
   referencekey,
   cost_category,
   nat_account_type,
   nat_account_number,
   nat_account_desc,
   inat_account_number2,
   inat_account_desc2,
   inat_account_number,
   inat_account_desc) AS LJ
 FULL JOIN (SELECT business_year,
   booking_month,
   corporate_division_id,
   corporate_division_desc,
    CASE
    WHEN warehouse_desc_short = 'HEE'
    THEN 1
    WHEN warehouse_desc_short = 'ETT'
    THEN 2
    WHEN warehouse_desc_short = 'OOS'
    THEN 3
    WHEN warehouse_desc_short = 'ZWA'
    THEN 4
    WHEN warehouse_desc_short = 'WEE'
    THEN 5
    WHEN warehouse_desc_short = 'WAD'
    THEN 6
    ELSE 9
    END AS warehouse_nr,
    CASE
    WHEN warehouse_desc_short NOT IN ('HEE', 'ETT', 'OOS', 'ZWA', 'WEE', 'WAD', 'TIE')
    THEN 'TIE'
    ELSE warehouse_desc_short
    END AS warehouse_desc_short,
    CASE
    WHEN warehouse_desc_short NOT IN ('HEE', 'ETT', 'OOS', 'ZWA', 'WEE', 'WAD', 'TIE')
    THEN 'Tiel'
    ELSE warehouse_desc
    END AS warehouse_desc,
   cost_center,
   referencekey,
   cost_category,
    CASE
    WHEN STRPOS(UPPER(nat_account_desc), 'KALK') <> 0
    THEN 'Gecalculeerd'
    ELSE 'Gefactureerd'
    END AS nat_account_type,
   nat_account_number,
   nat_account_desc,
   inat_account_number2,
   inat_account_desc2,
   inat_account_number,
   inat_account_desc,
   SUM(value_costs) AS value_costs
  FROM ldl_s_conl_workbench.t_i_cost_sapbw_logistics_2
  WHERE business_year = 2020
  GROUP BY business_year,
   booking_month,
   corporate_division_id,
   corporate_division_desc,
   warehouse_nr,
   t_i_cost_sapbw_logistics.warehouse_desc_short,
   warehouse_desc,
   cost_center,
   referencekey,
   cost_category,
   nat_account_type,
   nat_account_number,
   nat_account_desc,
   inat_account_number2,
   inat_account_desc2,
   inat_account_number,
   inat_account_desc) AS VJ ON LJ.business_year = VJ.business_year + 1 AND LJ.booking_month = VJ.booking_month + 100 AND
           LJ.warehouse_nr = VJ.warehouse_nr AND LJ.warehouse_desc_short = VJ.warehouse_desc_short AND LJ.corporate_division_id
          = VJ.corporate_division_id AND LJ.nat_account_number = VJ.nat_account_number AND LJ.inat_account_number = VJ.inat_account_number
        AND LJ.inat_account_number2 = VJ.inat_account_number2 AND LJ.referencekey = VJ.referencekey AND LJ.cost_category
     = VJ.cost_category AND LJ.cost_center = VJ.cost_center
GROUP BY warehouse_reporting_data,
 business_year,
 booking_month,
 corporate_division_id,
 corporate_division_desc,
 warehouse_nr,
 warehouse_desc_short,
 warehouse_desc,
 cost_center,
 referencekey,
 cost_category,
 nat_account_type,
 nat_account_number,
 nat_account_desc,
 inat_account_number2,
 inat_account_desc2,
 inat_account_number,
 inat_account_desc
HAVING warehouse_reporting_data = 'Y';