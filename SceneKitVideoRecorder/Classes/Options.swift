//
//  Options.swift
//
//  Created by Omer Karisman on 2017/08/29.
//

import UIKit
import SceneKit
import AVFoundation

extension SceneKitVideoRecorder {
  public struct Options {
    public var timeScale: Int32
    public var videoSize: CGSize
    public var fps: Int
    public var outputUrl: URL
    public var audioOnlyUrl: URL
    public var videoOnlyUrl: URL
    public var fileType: String
    public var codec: String
    public var videoCompressionSettings:  [String : Any]
    public var deleteFileIfExists: Bool
    public var useMicrophone: Bool
    public var audioSampleRate: Int32
    public var antialiasingMode: SCNAntialiasingMode
    public var videoDelayCompensation: Double

    public static var `default`: Options {
      return Options(timeScale: 1000,
                     videoSize: CGSize(width: 720, height: 1280),
                     fps: 60,
                     outputUrl: URL(fileURLWithPath: NSTemporaryDirectory() + "output.mp4"),
                     audioOnlyUrl: URL(fileURLWithPath: NSTemporaryDirectory() + "audio.m4a"),
                     videoOnlyUrl: URL(fileURLWithPath: NSTemporaryDirectory() + "video.mp4"),
                     fileType: AVFileType.m4v.rawValue,
                     codec: AVVideoCodecH264,
                     videoCompressionSettings: [:],
                     deleteFileIfExists: true,
                     useMicrophone: true,
                     audioSampleRate: 12000,
                     antialiasingMode: .multisampling4X,
                     videoDelayCompensation: 0.0)
    }
    
    var assetWriterVideoInputSettings: [String : Any] {
      return [
        AVVideoCodecKey: codec,
        AVVideoWidthKey: videoSize.width,
        AVVideoHeightKey: videoSize.height,
        AVVideoCompressionPropertiesKey: videoCompressionSettings
      ]
    }
    
    var assetWriterAudioInputSettings: [String : Any] {
      return [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: audioSampleRate,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
      ]
    }
    
    var sourcePixelBufferAttributes: [String : Any] {
      return [
        kCVPixelBufferPixelFormatTypeKey as String: NSNumber(value: kCVPixelFormatType_32ARGB),
        kCVPixelBufferWidthKey as String: videoSize.width,
        kCVPixelBufferHeightKey as String: videoSize.height,
      ]
    }
  }
}

