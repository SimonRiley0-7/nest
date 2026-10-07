import React, { useState, useEffect } from 'react';
import { Tag, Sparkles, Clock, Flame, ChevronRight } from 'lucide-react';

export default function FlashAdCarousel({ ads, onSelectAd }) {
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    if (!ads || ads.length === 0) return;
    const interval = setInterval(() => {
      setCurrentIndex((prev) => (prev + 1) % ads.length);
    }, 4500);
    return () => clearInterval(interval);
  }, [ads]);

  if (!ads || ads.length === 0) return null;
  const currentAd = ads[currentIndex];

  return (
    <div className="relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-900 via-indigo-950 to-slate-900 border border-indigo-500/30 p-4 md:p-6 shadow-2xl">
      <div className="absolute top-0 right-0 w-64 h-64 bg-indigo-500/10 rounded-full blur-3xl pointer-events-none" />
      
      <div className="flex items-center justify-between gap-4 mb-3">
        <div className="flex items-center gap-2">
          <span className="flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-gradient-to-r from-amber-500 to-red-500 text-white text-xs font-bold shadow-lg shadow-amber-500/20 animate-pulse">
            <Flame className="w-3.5 h-3.5" />
            <span>FLASH DEAL</span>
          </span>
          <span className="text-xs text-slate-400 flex items-center gap-1">
            <Clock className="w-3 h-3" /> Ends in 04d 18h
          </span>
        </div>

        {/* Indicators */}
        <div className="flex items-center gap-1.5">
          {ads.map((_, idx) => (
            <button
              key={idx}
              onClick={() => setCurrentIndex(idx)}
              className={`h-1.5 rounded-full transition-all ${
                idx === currentIndex ? 'w-6 bg-indigo-400' : 'w-2 bg-slate-700'
              }`}
            />
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 items-center">
        <div className="md:col-span-2 space-y-2">
          <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-md bg-indigo-500/20 text-indigo-300 text-xs font-semibold border border-indigo-500/30">
            <Sparkles className="w-3 h-3" /> Sponsored Builder Project
          </div>
          <h3 className="text-xl font-bold text-white tracking-tight">{currentAd.title}</h3>
          <p className="text-sm text-slate-300 line-clamp-2">{currentAd.description}</p>

          <div className="flex items-center gap-3 pt-2">
            <div className="bg-emerald-500/20 text-emerald-300 text-xs font-bold px-3 py-1 rounded-lg border border-emerald-500/30 flex items-center gap-1">
              <Tag className="w-3.5 h-3.5" />
              <span>{currentAd.discountTag || 'Special Builder Pricing'}</span>
            </div>
            <span className="text-lg font-extrabold text-white">{currentAd.priceFormatted}</span>
          </div>
        </div>

        <div className="relative group rounded-xl overflow-hidden aspect-video border border-slate-700">
          <img
            src={currentAd.images[0]}
            alt={currentAd.title}
            className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-slate-950/80 via-transparent to-transparent flex items-end p-3">
            <button
              onClick={() => onSelectAd(currentAd)}
              className="w-full py-2 px-3 rounded-lg bg-indigo-600 hover:bg-indigo-500 text-white text-xs font-bold flex items-center justify-center gap-1 transition-all shadow-lg"
            >
              <span>Explore Project</span>
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
