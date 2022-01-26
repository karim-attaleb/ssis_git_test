CREATE TABLE [FF].[JachtExamenTheoretisch] (
    [IndieningID]                  INT             NOT NULL,
    [JachtExamenTheoretischTypeID] NVARCHAR (15)   NOT NULL,
    [PrivacyToelating]             BIT             NULL,
    [Bedrag]                       DECIMAL (10, 2) NULL,
    [SoftDeleted]                  BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]                   ROWVERSION      NOT NULL,
    CONSTRAINT [PK_JachtExamenTheoretisch] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_JachtExamenTheoretisch_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_JachtExamenTheoretisch_JachtExamenTheoretischType] FOREIGN KEY ([JachtExamenTheoretischTypeID]) REFERENCES [FF].[JachtExamenTheoretischType] ([JachtExamenTheoretischTypeID])
);

