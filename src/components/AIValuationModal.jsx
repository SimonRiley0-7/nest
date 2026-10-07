import React from 'react';
import { X, Sparkles, TrendingUp, AlertTriangle, ShieldCheck, MapPin } from 'lucide-react';
import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer, CartesianGrid } from 'recharts';

export default function AIValuationModal({ property, onClose }) {
  if (!property) return null;

  // Generate 5-year trend forecast
  const basePriceCr = property.price / 10000000;
  const currentYear = new Date().getFullYear();
  const annualRate = property.projected5YrAppreciation / 100 / 5;

  const data = [
    { year: currentYear, value: Number(basePriceCr.toFixed(2)) },
    { year: currentYear + 1, value: Number((basePriceCr * (1 + annualRate)).toFixed(2)) },
    { year: currentYear + 2, value: Number((basePriceCr * Math.pow(1 + annualRate, 2)).toFixed(2)) },
    { year: currentYear + 3, value: Number((basePriceCr * Math.pow(1 + annualRate, 3)).toFixed(2)) },
    { year: currentYear + 4, value: Number((basePriceCr * Math.pow(1 + annualRate, 4)).toFixed(2)) },
    { year: currentYear + 5, value: Number((basePriceCr * Math.pow(1 + annualRate, 5)).toFixed(2)) },
  ];

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-md animate-fadeIn">
      <div className="glass-card max-w-2xl w-full rounded-2xl p-6 space-y-5 border border-indigo-500/30 max-h-[90vh] overflow-y-auto">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div className="flex items-center gap-2.5">
            <div className="w-10 h-10 rounded-xl bg-indigo-600/20 text-indigo-400 flex items-center justify-center border border-indigo-500/30">
              <Sparkles className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-white">AI Property Valuation & Growth Forecast</h2>
              <p className="text-xs text-slate-400">{property.title} • {property.location}</p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-1.5 rounded-lg bg-slate-800 text-slate-400 hover:text-white hover:bg-slate-700"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Primary Valuation Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
          <div className="bg-slate-900/80 p-3.5 rounded-xl border border-slate-800">
            <div className="text-xs text-slate-400">Current Listing Price</div>
            <div className="text-xl font-black text-white mt-1">{property.priceFormatted}</div>
          </div>

          <div className="bg-indigo-950/60 p-3.5 rounded-xl border border-indigo-500/40">
            <div className="text-xs text-indigo-300 font-medium flex items-center gap-1">
              <Sparkles className="w-3.5 h-3.5" /> Fair Market Value
            </div>
            <div className="text-xl font-black text-indigo-200 mt-1">
              ₹{(property.estimatedValuation / 10000000).toFixed(2)} Cr
            </div>
            <span className="text-[10px] text-emerald-400 font-semibold">+5.2% Under-valued</span>
          </div>

          <div className="bg-emerald-950/60 p-3.5 rounded-xl border border-emerald-500/40">
            <div className="text-xs text-emerald-300 font-medium flex items-center gap-1">
              <TrendingUp className="w-3.5 h-3.5" /> 5-Yr Growth Forecast
            </div>
            <div className="text-xl font-black text-emerald-300 mt-1">
              +{property.projected5YrAppreciation}%
            </div>
            <span className="text-[10px] text-slate-300">Infra Signal: High</span>
          </div>
        </div>

        {/* Interactive Growth Chart */}
        <div className="bg-slate-900/80 p-4 rounded-xl border border-slate-800 space-y-2">
          <h3 className="text-xs font-bold text-slate-300 uppercase tracking-wider">
            Predicted Capital Appreciation Curve (in ₹ Cr)
          </h3>
          <div className="h-56 w-full pt-2">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={data}>
                <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
                <XAxis dataKey="year" stroke="#94a3b8" fontSize={12} />
                <YAxis stroke="#94a3b8" fontSize={12} domain={['auto', 'auto']} />
                <Tooltip
                  contentStyle={{ backgroundColor: '#0f172a', borderColor: '#6366f1', borderRadius: '8px' }}
                  labelStyle={{ color: '#fff', fontWeight: 'bold' }}
                />
                <Line
                  type="monotone"
                  dataKey="value"
                  stroke="#6366f1"
                  strokeWidth={3}
                  dot={{ fill: '#818cf8', r: 5 }}
                  activeDot={{ r: 7 }}
                />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* AI Key Insights */}
        <div className="space-y-2 text-xs">
          <h3 className="font-bold text-slate-200">AI Valuation Drivers & Infrastructure Signals:</h3>
          <ul className="space-y-1.5 text-slate-300">
            <li className="flex items-start gap-2 bg-slate-900/40 p-2 rounded-lg border border-slate-800">
              <span className="text-indigo-400 font-bold">•</span>
              <span><strong>Metro & Transit Hub:</strong> Upcoming metro line within 600m adds ~14% premium over next 36 months.</span>
            </li>
            <li className="flex items-start gap-2 bg-slate-900/40 p-2 rounded-lg border border-slate-800">
              <span className="text-indigo-400 font-bold">•</span>
              <span><strong>Micro-Market Benchmark:</strong> Similar 3BHKs in {property.location} average ₹7,800/sqft vs current ₹7,297/sqft.</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
}
