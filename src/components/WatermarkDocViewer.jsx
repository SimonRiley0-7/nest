import React, { useState } from 'react';
import { X, ShieldCheck, Lock, Download, AlertTriangle, Eye, CheckCircle2, History, Layers } from 'lucide-react';

export default function WatermarkDocViewer({ property, onClose }) {
  const [selectedDoc, setSelectedDoc] = useState(property?.legalDocs[0]);
  const [accessLogs, setAccessLogs] = useState([
    { user: 'Buyer_ID_9901', time: 'Just now', action: 'NEST Watermarked Preview Generated' },
    { user: 'Govt_RERA_Validator', time: '12 mins ago', action: 'NEST Protocol Registry Authenticated' }
  ]);

  if (!property || !selectedDoc) return null;

  const watermarkText = `NEST SECURITY PROTOCOL • VERIFIED PREVIEW ONLY • WATERMARK #89201 • ${new Date().toLocaleDateString()}`;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-md animate-fadeIn">
      <div className="glass-card max-w-3xl w-full rounded-2xl p-6 space-y-5 border border-amber-500/40 max-h-[90vh] overflow-y-auto">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-amber-500/20 text-amber-400 flex items-center justify-center border border-amber-500/30">
              <ShieldCheck className="w-5 h-5" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h2 className="text-lg font-bold text-white">NEST Encrypted Legal Vault</h2>
                <span className="bg-amber-500/20 text-amber-300 text-[10px] font-bold px-2 py-0.5 rounded-full border border-amber-500/30">
                  RERA Authenticated
                </span>
              </div>
              <p className="text-xs text-slate-400">Encrypted at rest • View-only watermarked preview • Download protection enabled</p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-1.5 rounded-lg bg-slate-800 text-slate-400 hover:text-white hover:bg-slate-700"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Document Tabs */}
        <div className="flex items-center gap-2 overflow-x-auto pb-1">
          {property.legalDocs.map((doc) => (
            <button
              key={doc.id}
              onClick={() => setSelectedDoc(doc)}
              className={`px-3 py-1.5 rounded-lg text-xs font-semibold whitespace-nowrap transition-all ${
                selectedDoc.id === doc.id
                  ? 'bg-amber-500 text-slate-950 shadow-md font-bold'
                  : 'bg-slate-900 text-slate-300 hover:bg-slate-800 border border-slate-800'
              }`}
            >
              {doc.title}
            </button>
          ))}
        </div>

        {/* Canvas Preview Container with Watermark Overlay */}
        <div className="relative bg-slate-900 rounded-xl border border-slate-800 p-6 min-h-[300px] flex flex-col justify-between overflow-hidden select-none">
          {/* Diagonal Watermark Lines */}
          <div className="absolute inset-0 pointer-events-none flex flex-col justify-around opacity-15 rotate-[-25deg] scale-125 z-10">
            <div className="text-amber-400 font-black text-sm tracking-widest text-center whitespace-nowrap">{watermarkText}</div>
            <div className="text-amber-400 font-black text-sm tracking-widest text-center whitespace-nowrap">{watermarkText}</div>
            <div className="text-amber-400 font-black text-sm tracking-widest text-center whitespace-nowrap">{watermarkText}</div>
          </div>

          {/* Document Content Mock */}
          <div className="relative z-0 space-y-4">
            <div className="flex items-center justify-between border-b border-slate-800 pb-3">
              <div>
                <h3 className="font-bold text-slate-100 text-base">{selectedDoc.title}</h3>
                <div className="text-xs text-amber-400 font-mono">NEST Reg ID: {selectedDoc.regNo}</div>
              </div>
              <span className="flex items-center gap-1 text-xs text-emerald-400 font-semibold bg-emerald-950/60 px-2.5 py-1 rounded-md border border-emerald-500/30">
                <CheckCircle2 className="w-3.5 h-3.5" /> Registry Authenticated
              </span>
            </div>

            <div className="space-y-2 text-xs text-slate-300 font-mono leading-relaxed bg-slate-950/80 p-4 rounded-lg border border-slate-800/80">
              <p>[NEST LEGAL PROTOCOL - GOVERNMENT LAND & PROPERTY REGISTRY RECORD]</p>
              <p>SCHEDULE OF PROPERTY: {property.title} located at {property.location}.</p>
              <p>TITLE HOLDER: {property.sellerName} ({property.companyName || 'Private Owner'}).</p>
              <p>ENCUMBRANCE STATUS: Clear Title • Zero Mortgage Liability • BBMP/PMC Approval Verified.</p>
              <p className="text-amber-500 text-[10px] pt-2">*** THIS PREVIEW IS PROTECTED BY NEST WATERMARK PROTOCOL ***</p>
            </div>
          </div>

          {/* Security Notice Footer */}
          <div className="relative z-0 pt-4 flex items-center justify-between text-xs border-t border-slate-800 text-slate-400">
            <span className="flex items-center gap-1.5 text-amber-400 font-medium">
              <Lock className="w-3.5 h-3.5" /> Downloads restricted for seller & buyer privacy
            </span>
            <span className="text-[11px] text-slate-500">Audit ID: #NEST-LOG-{Math.floor(10000 + Math.random() * 90000)}</span>
          </div>
        </div>

        {/* Access Audit Trail */}
        <div className="bg-slate-950/60 p-3 rounded-xl border border-slate-800 space-y-2 text-xs">
          <div className="font-bold text-slate-300 flex items-center gap-1">
            <History className="w-3.5 h-3.5 text-amber-400" /> NEST Security Audit Trail
          </div>
          <div className="space-y-1 text-slate-400 text-[11px]">
            {accessLogs.map((log, idx) => (
              <div key={idx} className="flex items-center justify-between">
                <span>{log.action} ({log.user})</span>
                <span className="text-slate-500">{log.time}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
