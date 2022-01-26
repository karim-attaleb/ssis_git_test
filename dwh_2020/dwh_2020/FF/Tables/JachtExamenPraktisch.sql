CREATE TABLE [FF].[JachtExamenPraktisch] (
    [IndieningID]                INT             NOT NULL,
    [JachtExamenPraktischTypeID] NVARCHAR (15)   NOT NULL,
    [PrivacyToelating]           BIT             NULL,
    [Bedrag]                     DECIMAL (10, 2) NULL,
    [BijlageStrafregisterFlag]   BIT             DEFAULT ((0)) NOT NULL,
    [SoftDeleted]                BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]                 ROWVERSION      NOT NULL,
    [BijlageMedischAttestFlag]   BIT             CONSTRAINT [DF_JachtExamenPraktisch_BijlageStrafregisterFlag1] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JachtExamenPraktisch] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_JachtExamenPraktisch_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_JachtExamenPraktisch_JachtExamenPraktischType] FOREIGN KEY ([JachtExamenPraktischTypeID]) REFERENCES [FF].[JachtExamenPraktischType] ([JachtExamenPraktischTypeID])
);

