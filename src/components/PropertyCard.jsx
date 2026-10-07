import React from 'react';
import { MapPin, Sparkles, ShieldCheck, PhoneCall, FileText, TrendingUp, Building2, User, Eye, CheckCircle2 } from 'lucide-react';

export default function PropertyCard({
  property,
  onOpenValuation,
  onOpenCallMasking,
  onOpenDocs,
  onToggleCompare,
  isCompared,
}) {
  return (
    <div className="glass-card glass-card-hover rounded-2xl overflow-hidden flex flex-col justify-between border border-slate-800">
      {/* Media Banner */}
      <div className="relative aspect-video overflow-hidden group">
        <img
          src={property.images[0]}
          alt={property.title}
          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-slate-950/90 via-slate-950/20 to-transparent" />

        {/* Badges */}
        <div className="absolute top-3 left-3 flex flex-wrap gap-1.5 z-10">
          <span
            className={`px-2.5 py-1 rounded-md text-[11px] font-bold shadow-md flex items-center gap-1 ${
              property.sellerRole === 'builder'
                ? 'bg-amber-500/90 text-slate-950'
                : 'bg-emerald-500/90 text-slate-950'
            }`}
          >
            {property.sellerRole === 'builder' ? <Building2 className="w-3 h-3" /> : <User className="w-3 h-3" />}
            <span className="capitalize">{property.sellerRole}</span>
          </span>

          {property.discountTag && (
            <span className="px-2.5 py-1 rounded-md bg-indigo-600/90 text-white text-[11px] font-bold shadow-md">
              {property.discountTag}
            </span>
          )}
        </div>

        {/* AI Suitability Pill */}
        <div className="absolute top-3 right-3 z-10 bg-slate-900/90 backdrop-blur-md px-2.5 py-1 rounded-lg border border-indigo-500/40 text-xs font-bold text-indigo-300 flex items-center gap-1">
          <Sparkles className="w-3.5 h-3.5 text-indigo-400" />
          <span>{property.suitabilityScore}% Match</span>
        </div>

        {/* Price & Location Overlay */}
        <div className="absolute bottom-3 left-3 right-3 flex items-end justify-between z-10">
          <div>
            <div className="text-2xl font-black text-white tracking-tight">{property.priceFormatted}</div>
            <div className="text-xs text-slate-300 flex items-center gap-1">
              <MapPin className="w-3.5 h-3.5 text-indigo-400" />
              <span>{property.location}</span>
            </div>
          </div>
          <div className="text-right">
            <span className="text-xs font-semibold text-slate-300 bg-slate-900/80 px-2 py-1 rounded border border-slate-700">
              {property.bhk} • {property.areaSqFt} sqft
            </span>
          </div>
        </div>
      </div>

      {/* Body Content */}
      <div className="p-4 space-y-3 flex-1 flex flex-col justify-between">
        <div>
          <h3 className="font-bold text-slate-100 text-base leading-snug line-clamp-1">{property.title}</h3>
          <p className="text-xs text-slate-400 line-clamp-2 mt-1">{property.description}</p>
        </div>

        {/* Seller Info & RERA */}
        <div className="flex items-center justify-between text-xs text-slate-400 pt-2 border-t border-slate-800/80">
          <span className="font-medium text-slate-300">{property.sellerName}</span>
          <span className="flex items-center gap-1 text-emerald-400 font-semibold">
            <CheckCircle2 className="w-3.5 h-3.5" /> RERA Verified
          </span>
        </div>

        {/* AI Valuation & Appreciation Quick Stats */}
        <div className="bg-slate-950/60 p-2.5 rounded-xl border border-slate-800/80 grid grid-cols-2 gap-2 text-xs">
          <div>
            <div className="text-[10px] text-slate-400 flex items-center gap-1">
              <Sparkles className="w-3 h-3 text-indigo-400" /> AI Est. Fair Value
            </div>
            <div className="font-bold text-slate-200">₹{(property.estimatedValuation / 10000000).toFixed(2)} Cr</div>
          </div>
          <div>
            <div className="text-[10px] text-slate-400 flex items-center gap-1">
              <TrendingUp className="w-3 h-3 text-emerald-400" /> 5-Yr Growth Est.
            </div>
            <div className="font-bold text-emerald-400">+{property.projected5YrAppreciation}%</div>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="grid grid-cols-2 gap-2 pt-1">
          <button
            onClick={() => onOpenValuation(property)}
            className="py-2 px-3 rounded-lg bg-indigo-600/20 hover:bg-indigo-600/30 text-indigo-300 text-xs font-semibold border border-indigo-500/30 transition-colors flex items-center justify-center gap-1.5"
          >
            <TrendingUp className="w-3.5 h-3.5 text-indigo-400" />
            <span>AI Valuation</span>
          </button>

          <button
            onClick={() => onOpenDocs(property)}
            className="py-2 px-3 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-200 text-xs font-semibold border border-slate-700 transition-colors flex items-center justify-center gap-1.5"
          >
            <FileText className="w-3.5 h-3.5 text-amber-400" />
            <span>Legal Docs</span>
          </button>
        </div>

        <div className="flex items-center gap-2 pt-1">
          <button
            onClick={() => onOpenCallMasking(property)}
            className="flex-1 py-2 px-3 rounded-lg bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white text-xs font-bold transition-all shadow-md flex items-center justify-center gap-1.5"
          >
            <PhoneCall className="w-3.5 h-3.5" />
            <span>Masked Call</span>
          </button>

          <button
            onClick={() => onToggleCompare(property)}
            className={`py-2 px-3 rounded-lg text-xs font-semibold border transition-all flex items-center gap-1 ${
              isCompared
                ? 'bg-indigo-600 text-white border-indigo-500'
                : 'bg-slate-900 text-slate-300 border-slate-700 hover:border-slate-600'
            }`}
          >
            <span>{isCompared ? 'Compared' : '+ Compare'}</span>
          </button>
        </div>
      </div>
    </div>
  );
}
