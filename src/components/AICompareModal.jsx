import React from 'react';
import { X, Sparkles, CheckCircle, XCircle, AlertTriangle, ShieldCheck, Scale } from 'lucide-react';

export default function AICompareModal({ properties, onClose }) {
  if (!properties || properties.length === 0) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-md animate-fadeIn">
      <div className="glass-card max-w-4xl w-full rounded-2xl p-6 space-y-6 border border-indigo-500/30 max-h-[90vh] overflow-y-auto">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-gradient-to-tr from-indigo-600 to-violet-600 text-white flex items-center justify-center shadow-lg shadow-indigo-500/30">
              <Scale className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-xl font-bold text-white">Ask AI - Unified Property Comparison</h2>
              <p className="text-xs text-slate-400">Side-by-side live database analytical reasoning & geological risk assessment</p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-1.5 rounded-lg bg-slate-800 text-slate-400 hover:text-white hover:bg-slate-700"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Comparative Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {properties.map((prop) => (
            <div key={prop.id} className="bg-slate-900/90 rounded-xl p-4 border border-slate-800 space-y-4 flex flex-col justify-between">
              {/* Thumbnail & Title */}
              <div>
                <img
                  src={prop.images[0]}
                  alt={prop.title}
                  className="w-full h-36 object-cover rounded-lg border border-slate-700 mb-3"
                />
                <h3 className="font-bold text-slate-100 text-base">{prop.title}</h3>
                <div className="text-xs text-slate-400">{prop.location}</div>
                <div className="text-xl font-black text-white mt-1">{prop.priceFormatted}</div>
              </div>

              {/* Unified Suitability Score Pill */}
              <div className="bg-indigo-950/60 p-3 rounded-xl border border-indigo-500/30 flex items-center justify-between">
                <span className="text-xs font-semibold text-indigo-300 flex items-center gap-1.5">
                  <Sparkles className="w-4 h-4 text-indigo-400" /> Unified Suitability Score
                </span>
                <span className="text-lg font-black text-indigo-200">{prop.suitabilityScore}%</span>
              </div>

              {/* Why Choose vs Why Not */}
              <div className="space-y-2 text-xs">
                <div className="bg-emerald-950/30 p-2.5 rounded-lg border border-emerald-500/30 space-y-1">
                  <div className="font-bold text-emerald-400 flex items-center gap-1">
                    <CheckCircle className="w-3.5 h-3.5" /> Why Choose This Property
                  </div>
                  <p className="text-slate-300">
                    High 5-yr growth (+{prop.projected5YrAppreciation}%), excellent nearby amenities (schools/hospitals), and verified RERA document vault.
                  </p>
                </div>

                <div className="bg-amber-950/30 p-2.5 rounded-lg border border-amber-500/30 space-y-1">
                  <div className="font-bold text-amber-400 flex items-center gap-1">
                    <AlertTriangle className="w-3.5 h-3.5" /> Trade-offs / Considerations
                  </div>
                  <p className="text-slate-300">
                    Slightly higher initial booking deposit required compared to micro-market average.
                  </p>
                </div>
              </div>

              {/* Environmental & Geological Risks */}
              <div className="bg-slate-950/80 p-3 rounded-xl border border-slate-800 space-y-1.5 text-xs">
                <div className="font-bold text-slate-300 flex items-center gap-1">
                  <ShieldCheck className="w-3.5 h-3.5 text-indigo-400" /> Environmental & Geological Risk Profile
                </div>
                <div className="grid grid-cols-2 gap-2 text-[11px] text-slate-400 pt-1">
                  <div>Seismic: <span className="text-slate-200 font-semibold">{prop.geologicalRisks.seismicZone}</span></div>
                  <div>Flood: <span className="text-slate-200 font-semibold">{prop.geologicalRisks.floodRisk}</span></div>
                  <div>AQI: <span className="text-slate-200 font-semibold">{prop.geologicalRisks.airQualityIndex}</span></div>
                  <div>Water Table: <span className="text-slate-200 font-semibold">{prop.geologicalRisks.groundwaterDepth}</span></div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
