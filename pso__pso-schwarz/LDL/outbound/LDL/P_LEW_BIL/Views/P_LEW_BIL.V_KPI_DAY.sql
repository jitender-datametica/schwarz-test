/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_KPI_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  26.03.2019    Dumitru Camerzan         Initial creation
#  1.1  26.03.2019    Dumitru Camerzan         Added country exclusion (org_type_id <> 20) in the top
#                                              select, extracting KPIs from the OLD data model.
#  1.1  26.03.2019    Dumitru Camerzan         Changed some comments
#  1.2  26.03.2019    Dumitru Camerzan         Improved syntax
#  1.3  27.03.2019    Dumitru Camerzan         Changed the filter on new core table
#  1.4  27.03.2019    Dumitru Camerzan         Added the handling of failed organization lookup (dummy orgs)
#  1.5  29.04.2019    Erich Kun                Modifying to a 1 to 1 View
#  1.6  18.12.2020    Mittler,Patrick          Exclude Kolli with ID 315
#  1.7  03.03.2021    Rekovsky,Marvin          Include Kolli with ID 315 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_kpi_day AS SELECT *
FROM ldl_p_lew_core_ac.v_wawi_indicator_day;