CREATE TABLE [FF].[FaunaBeheerPlan] (
    [IndieningID]      INT        NOT NULL,
    [VergaderingDatum] DATETIME   NULL,
    [SoftDeleted]      BIT        CONSTRAINT [DF_FaunaBeheerPlan_SoftDeleted] DEFAULT ((0)) NOT NULL,
    [RowVersion]       ROWVERSION NOT NULL,
    CONSTRAINT [PK_FaunaBeheerPlan] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [PK_FaunaBeheerPlan_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

