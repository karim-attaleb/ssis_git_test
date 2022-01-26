CREATE TABLE [DR].[WerkThema] (
    [WerkThemaID]      NVARCHAR (15)  NOT NULL,
    [HoofdWerkThemaID] NVARCHAR (15)  NULL,
    [ExtraInfo]        NVARCHAR (255) NULL,
    [Description]      NVARCHAR (50)  NOT NULL,
    [DependencySet]    NVARCHAR (200) NULL,
    [SortOrder]        INT            NULL,
    [Comment]          NVARCHAR (800) NULL,
    [SoftDeleted]      BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]       ROWVERSION     NOT NULL,
    CONSTRAINT [PK_WerkThema] PRIMARY KEY CLUSTERED ([WerkThemaID] ASC),
    CONSTRAINT [FK_WerkThema_HoofdrganisatieThema] FOREIGN KEY ([HoofdWerkThemaID]) REFERENCES [DR].[WerkThema] ([WerkThemaID])
);

