CREATE TABLE [IR].[WorkflowHistory] (
    [WorkflowHistoryID]    INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [WorkflowTypeID]       NVARCHAR (15)  NOT NULL,
    [EntityTable]          NVARCHAR (128) NOT NULL,
    [EntityID]             INT            NOT NULL,
    [Date]                 DATETIME       NULL,
    [WorkflowEventID]      NVARCHAR (15)  NOT NULL,
    [FromWorkflowStatusID] NVARCHAR (15)  NOT NULL,
    [ToWorkflowStatusID]   NVARCHAR (15)  NOT NULL,
    [EntityValue]          NVARCHAR (800) NULL,
    [ActorID]              NVARCHAR (250) NULL,
    [ActorComment]         NVARCHAR (800) NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_WorkflowHistory_WorkflowHistoryID] PRIMARY KEY CLUSTERED ([WorkflowHistoryID] ASC),
    CONSTRAINT [FK_WorkflowHistory_WorkflowEvent] FOREIGN KEY ([WorkflowEventID]) REFERENCES [IR].[WorkflowEvent] ([WorkflowEventID]),
    CONSTRAINT [FK_WorkflowHistory_WorkflowStatus_From] FOREIGN KEY ([FromWorkflowStatusID]) REFERENCES [IR].[WorkflowStatus] ([WorkflowStatusID]),
    CONSTRAINT [FK_WorkflowHistory_WorkflowStatus_TO] FOREIGN KEY ([ToWorkflowStatusID]) REFERENCES [IR].[WorkflowStatus] ([WorkflowStatusID]),
    CONSTRAINT [FK_WorkflowHistory_WorkflowType] FOREIGN KEY ([WorkflowTypeID]) REFERENCES [IR].[WorkflowType] ([WorkflowTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_WorkflowHistory_EntityID]
    ON [IR].[WorkflowHistory]([EntityID] ASC)
    ON [Indexes];

