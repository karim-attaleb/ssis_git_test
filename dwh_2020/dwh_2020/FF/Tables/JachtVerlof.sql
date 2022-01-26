CREATE TABLE [FF].[JachtVerlof] (
    [IndieningID]                         INT           NOT NULL,
    [JachtVerlofTypeID]                   NVARCHAR (15) NULL,
    [JachtVerlofNummer]                   NVARCHAR (15) NULL,
    [VolgNummerAanvrager]                 INT           NULL,
    [BijlageStrafregisterFlag]            BIT           DEFAULT ((0)) NOT NULL,
    [BijlageJachtexamenFlag]              BIT           DEFAULT ((0)) NOT NULL,
    [BijlageVerzekeringFlag]              BIT           DEFAULT ((0)) NOT NULL,
    [BijlagePasfotoFlag]                  BIT           DEFAULT ((0)) NOT NULL,
    [BijlageBetalingFlag]                 BIT           DEFAULT ((0)) NOT NULL,
    [MagdaPasfotoFlag]                    BIT           DEFAULT ((0)) NOT NULL,
    [VorigJachtVerlofNummer]              NVARCHAR (15) NULL,
    [VorigJachtVerlofHistoriekID]         INT           NULL,
    [VorigJachtVerlofIndieningID]         INT           NULL,
    [GeldigJachtExamenID]                 INT           NULL,
    [JachtExamenTheoretischDossierNummer] NVARCHAR (15) NULL,
    [SoftDeleted]                         BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]                          ROWVERSION    NOT NULL,
    [BetalingTypeID]                      NVARCHAR (15) NULL,
    [Bedrag]                              DECIMAL (10)  NULL,
    [JachtExamenPraktischDossierNummer]   NVARCHAR (15) NULL,
    [BijlageMedischAttestFlag]            BIT           DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JachtVerlof] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_JachtVerlof_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_JachtVerlof_JachtExamen] FOREIGN KEY ([GeldigJachtExamenID]) REFERENCES [FF].[JachtExamen] ([JachtExamenID]),
    CONSTRAINT [FK_JachtVerlof_JachtVerlof] FOREIGN KEY ([VorigJachtVerlofIndieningID]) REFERENCES [FF].[JachtVerlof] ([IndieningID]),
    CONSTRAINT [FK_JachtVerlof_JachtVerlofHistoriek] FOREIGN KEY ([VorigJachtVerlofHistoriekID]) REFERENCES [FF].[JachtVerlofHistoriek] ([JachtVerlofHistoriekID]),
    CONSTRAINT [FK_JachtVerlof_JachtVerlofType] FOREIGN KEY ([JachtVerlofTypeID]) REFERENCES [FF].[JachtVerlofType] ([JachtVerlofTypeID]),
    CONSTRAINT [FK_JachtVerlof_JachtVerlofVolgNummer] FOREIGN KEY ([VolgNummerAanvrager]) REFERENCES [FF].[JachtVerlofVolgNummer] ([VolgNummer])
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20220102-182511]
    ON [FF].[JachtVerlof]([JachtVerlofNummer] ASC);

