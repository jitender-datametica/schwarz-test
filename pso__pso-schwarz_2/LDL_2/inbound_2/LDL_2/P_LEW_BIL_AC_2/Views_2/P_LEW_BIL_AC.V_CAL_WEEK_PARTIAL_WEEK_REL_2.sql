/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_CAL_WEEK_PARTIAL_WEEK_REL.
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_CAL_WEEK_PARTIAL_WEEK_REL_2
/*
#DescStart#
#$Revision: 62789 $, $LastChangedBy: jsyrokosz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    dat_calendar
    , cy_week_partial_week_id1
    , cy_week_partial_week_id2
    , cy_week_partial_week_id
    , cy_day_sequence
) AS
SELECT 
    dat_calendar
    , cy_week_partial_week_id1
    , cy_week_partial_week_id2
    , cy_week_partial_week_id
    , cy_day_sequence
FROM P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK_REL_2
;

