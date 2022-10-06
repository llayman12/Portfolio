SELECT DISTINCT
    PV.Department,
    PV.Site,
    PV.HRN,
    PV.EpicEncounterId,
    PV.EncounterDate,
    PV.Encountertype,
    PV.Provider,
    PV.prov_type AS [Provider Type],
    E.EncounterId,
    E.EncounterDiagnosis AS [ICD Code],
    E.PlaceOfService AS 'Place of Service',
    POS.QUEST_COMMENT AS [POS Comment],
    E.HousingStatus AS 'Housing Status'

FROM Epic_Rpt.CHS_User.Program_Visit AS PV
   
JOIN Epic_Rpt.CHS_User.Encounter AS E
ON PV.EpicEncounterId = E.EpicEncounterId

LEFT JOIN Epic_Rpt.CHS_User.Client AS C
ON PV.HRN = C.HRN

LEFT JOIN Epic_Rpt.CHS_User.EncounterReason AS ER 
ON E.EncounterId = ER.EncounterId

LEFT JOIN Epic_Rpt.CHS_User.EncounterMedication AS ERx 
ON E.EncounterId = ERx.EncounterId

LEFT JOIN Epic_Rpt.BO_User.PAT_ENC_QUESR AS POS
ON PV.EpicEncounterId = POS.PAT_ENC_CSN_ID

LEFT JOIN Epic_Rpt.BO_User.PAT_ENC AS PE 
ON PV.EpicEncounterId = PE.PAT_ENC_CSN_ID

WHERE
    PV.EncounterDate BETWEEN '2022-01-01' AND GETDATE()
    AND PV.Department LIKE '%street%'
    AND POS.QUESR_ID = '100011'
