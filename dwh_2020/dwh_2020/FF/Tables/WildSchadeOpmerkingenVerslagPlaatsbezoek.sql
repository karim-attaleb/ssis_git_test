CREATE TABLE [FF].[WildSchadeOpmerkingenVerslagPlaatsbezoek] (
    [IndieningID]                                INT            NOT NULL,
    [DossierNummer]                              NVARCHAR (10)  NULL,
    [DossierNummerVolgNummer]                    INT            NULL,
    [Opmerkingen]                                NVARCHAR (MAX) NOT NULL,
    [CheckBijlageOpmerkingenVerslagPlaatsbezoek] BIT            NOT NULL,
    [SoftDeleted]                                BIT            CONSTRAINT [DF_WildSchadeOpmerkingenVerslagPlaatsbezoek_SoftDeleted] DEFAULT ((0)) NOT NULL,
    [RowVersion]                                 ROWVERSION     NOT NULL,
    CONSTRAINT [PK_WildSchadeOpmerkingenVerslagPlaatsbezoek] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_WildSchadeOpmerkingenVerslagPlaatsbezoek_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

